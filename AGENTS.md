# AGENTS.md

This guide is for contributors — human or LLM-assisted — adding rules to this
repository. It describes exactly how a single rule is structured, tested, and
validated so that an AI assistant (Copilot, Claude, `pi`, and so on) can produce
a correct, mergeable change. Read it completely before making changes.

## What this repository is

This repository is a [Vale](https://vale.sh)-compatible style package that
implements the
[*Salesforce Writing Style Guide*](https://developer.salesforce.com/docs/atlas.en-us.salesforce_pubs_style_guide.meta/salesforce_pubs_style_guide/overview.htm).

It is an ongoing, community-maintained effort — the guide is large, so new rules
are added over time. Contributions typically add **one rule at a time**, each
with a passing test. Never batch many unverified rules into a single change.

If you are prompting an LLM to help, give it this file as context and ask it to
implement one rule end-to-end (all three files below) and to prove it passes
`make run-behave` before moving on.

## What to implement vs. what to skip

### In scope — implement these

Rules that are **specific to Salesforce**, primarily from the guide's
[Styles A-Z](https://developer.salesforce.com/docs/atlas.en-us.salesforce_pubs_style_guide.meta/salesforce_pubs_style_guide/style_a-z.htm)
and
[Glossary](https://developer.salesforce.com/docs/atlas.en-us.salesforce_pubs_style_guide.meta/salesforce_pubs_style_guide/glossary_master.htm)
sections. Examples of in-scope rules:

- Salesforce product, feature, and edition names and their correct
  capitalization (for example, "Lightning Experience", "Salesforce admin" vs.
  "Salesforce administrator", "AppExchange", "Trailhead").
- Salesforce-specific term usage and preferred spellings ("log in" vs. "login",
  "setup" vs. "set up **in a Salesforce context**", "org" vs. "organization").
- Deprecated or forbidden Salesforce terminology and its replacement.
- Salesforce UI terminology conventions (for example, how to refer to Setup,
  tabs, objects, records).

### Out of scope — do NOT implement these

Generic English grammar, punctuation, or writing-mechanics rules that are **not
unique to Salesforce** and are already covered by general-purpose Vale packages
such as `Microsoft`, `Google`, or `Datadog`. If a rule would apply equally to
any product's documentation, skip it. Examples to skip:

- Article usage such as
  [a vs. an](https://developer.salesforce.com/docs/atlas.en-us.salesforce_pubs_style_guide.meta/salesforce_pubs_style_guide/style_a_an.htm).
- Generic passive voice, sentence length, Oxford comma, contractions,
  capitalization of headings, generic "e.g./i.e." usage, spacing after periods,
  and similar general style mechanics.
- Generic word-choice advice ("utilize" → "use") that is not Salesforce-specific.

When in doubt, ask: *"Would this rule exist verbatim in the Microsoft or Datadog
style package?"* If yes, skip it.

## Repository layout and conventions

Adding one rule always touches **three** locations. Use the existing
`SalesforceAdmin` rule as the reference implementation for all three.

```text
Salesforce/<RuleName>.yml          # 1. The Vale rule definition
fixtures/<RuleName>/vale.ini        # 2a. Isolates this single rule for testing
fixtures/<RuleName>/test.md         # 2b. Sample prose that triggers the rule
features/rules.feature              # 3. A Behave scenario asserting the output
```

### 1. The Vale rule — `Salesforce/<RuleName>.yml`

- File name is PascalCase and becomes the rule id `Salesforce.<RuleName>`.
- Always include a `link:` to the exact style-guide page the rule enforces.
- Default `level: suggestion` (match the guide's severity; only escalate to
  `warning`/`error` when the guide is prescriptive).
- Reference example — `Salesforce/SalesforceAdmin.yml`:

```yaml
extends: existence
message: "Use 'Salesforce admin' instead of '%s'. Note: For UI text and login documentation, use 'Salesforce administrator'."
level: suggestion
ignorecase: true
link: https://developer.salesforce.com/docs/atlas.en-us.salesforce_pubs_style_guide.meta/salesforce_pubs_style_guide/style_administrator.htm
tokens:
  - '(?<!Salesforce\s)\badmin\b'
exceptions:
  - 'administrator'
  - 'Salesforce administrator'
```

Choose the simplest Vale `extends` type that fits:

- `existence` — flag that a forbidden/discouraged term appears.
- `substitution` — map a wrong term to a preferred one (`swap:`), best for
  "use X instead of Y" rules.
- `capitalization` — enforce correct casing of product/feature names.
- `conditional` / `occurrence` — only when the above cannot express the rule.

Keep `%s` in the `message` so Vale substitutes the matched text. Use
`ignorecase: true` and `exceptions:` deliberately to avoid false positives
(match the precision of the reference rule, including lookarounds where needed).

> **`substitution` gotcha:** for `substitution` rules, `%s` is replaced with the
> **preferred** term (the value in `swap:`), *not* the matched text. Phrase the
> message around the replacement — for example `"'%s' is one word. Don't split
> it into two words."` — rather than `"Use 'X' instead of '%s'."`, which would
> read incorrectly.

### 2. The fixture — `fixtures/<RuleName>/`

- `vale.ini` isolates exactly one rule so the test output is deterministic.
  Copy `fixtures/SalesforceAdmin/vale.ini` and change the rule name:

  ```ini
  StylesPath = ../../

  MinAlertLevel = suggestion

  [*.md]
  Salesforce.<RuleName> = YES
  ```

- `test.md` must contain prose that triggers the rule **a known number of
  times** and also prose that must NOT trigger it (to prove exceptions and
  lookarounds work). Because only one rule is enabled, the fixture output is
  fully predictable — every triggered line must be accounted for in the feature
  table (see the strict-count note below).

### 3. The test — `features/rules.feature`

Add one `Scenario` per rule. The step definitions live in
`features/steps/steps.py`; do not modify them unless a genuinely new step is
required. Reference scenario:

```gherkin
Scenario: Salesforce administrator language
    When I test "SalesforceAdmin"
    Then the linter output should report the following issues:
        | File | Line | Rule | Message |
        | test.md | 11 | Salesforce.SalesforceAdmin | Use 'Salesforce admin' instead of 'admin'. Note: For UI text and login documentation, use 'Salesforce administrator'. |
        | test.md | 13 | Salesforce.SalesforceAdmin | ... |
```

- `When I test "<RuleName>"` runs Vale inside `fixtures/<RuleName>/`.
- The `Then` table must list **every** issue Vale reports — no more, no fewer.
  `steps.py` asserts that the reported issue count equals the expected count
  exactly (strict checking). If Vale reports 3 issues and you list 2, the test
  fails.
- `Line` is the 1-based line in `test.md`. The `Message` column must match the
  rule's `message:` verbatim (after `%s` substitution).

## Build, test, and validation

Environment is managed by the `Makefile` (creates a `venv` and installs
`vale`, `behave`, and `pymarkdownlnt` from `requirements.txt`).

```bash
make install       # create venv and install dependencies (run once)
make run-behave    # run the full Behave suite — THIS IS THE GATE
make vale-verbose  # run Vale across the repo with the same flags the tests use
make lint-md       # markdown lint the fixtures
```

**Definition of done for each rule:**

1. `make run-behave` passes with the new scenario included.
2. `make lint-md` passes (fixtures are valid, well-formed Markdown).
3. The rule's `.yml`, fixture directory, and feature scenario all exist and are
   consistent (same `<RuleName>`).

Never mark a rule complete without a green `make run-behave`. The GitHub Actions
`Tests` workflow (`.github/workflows/run-behave.yml`) runs both `make run-behave`
and `make lint-md` on every pull request and on pushes to `main`; a change that
fails locally will fail CI.

## Per-rule workflow

1. Pick an in-scope entry from the Styles A-Z / Glossary index that isn't
   already implemented. Skip anything already present in `/Salesforce`.
2. Read that entry's page to extract the exact rule, preferred term, and
   exceptions. Capture the page URL for the `link:` field.
3. Create `Salesforce/<RuleName>.yml`.
4. Create `fixtures/<RuleName>/vale.ini` and `fixtures/<RuleName>/test.md`.
5. Add a `Scenario` to `features/rules.feature`.
6. Run `make run-behave` and `make lint-md`; iterate on the regex/exceptions and
   expected table until both are green.
7. Open a pull request with a title like `Add <RuleName> rule` (one rule per
   PR). CI runs the same checks and must pass before merge.

## Guardrails

- **One rule per pull request / change set.** Keep changes small and verifiable.
- **Do not** edit `features/steps/steps.py`, the `Makefile`, CI workflow, or
  `.vale.ini` unless a task explicitly requires it. If you believe a shared file
  must change, explain why first.
- **Do not** invent style rules. Every rule must trace to a specific
  style-guide page recorded in its `link:` field.
- **Do not** weaken or delete existing rules or their tests to make the suite
  pass.
- Prefer precise regex with `exceptions:` and lookarounds over broad matches to
  keep false positives low.
- Keep `message` text professional, imperative, and consistent with existing
  rules ("Use 'X' instead of '%s'.").
- This project is neither maintained nor endorsed by Salesforce; do not add
  claims of affiliation.

## Tracking what exists and what's skipped

- The set of files in `/Salesforce` is the record of implemented rules; check it
  (and `features/rules.feature`) before adding a rule to avoid duplicates.
