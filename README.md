# Salesforce

[![Tests](https://github.com/sfadriaan/Salesforce/actions/workflows/run-behave.yml/badge.svg)](https://github.com/sfadriaan/Salesforce/actions/workflows/run-behave.yml)
[![Latest release](https://img.shields.io/github/v/release/sfadriaan/Salesforce?sort=semver)](https://github.com/sfadriaan/Salesforce/releases/latest)
[![License](https://img.shields.io/github/license/sfadriaan/Salesforce)](LICENSE)

> **NOTE**: This project is neither maintained nor endorsed by Salesforce.

This repository contains a [Vale-compatible](https://github.com/errata-ai/vale) implementation of the [*Salesforce Writing Style Guide*](https://developer.salesforce.com/docs/atlas.en-us.salesforce_pubs_style_guide.meta/salesforce_pubs_style_guide/overview.htm) ([LICENSE](https://www.salesforce.com/company/legal/)).

It helps writers keep Salesforce documentation consistent with the official style guide: correct product and feature names, preferred terminology and spellings, and flagged/forbidden terms.

## Getting Started

You need [Vale](https://vale.sh/docs/vale-cli/installation/) 3.0 or later.

1. Add the package to your Vale configuration file (`.vale.ini`) and point it at the latest release asset:

   ```ini
   StylesPath = styles
   MinAlertLevel = suggestion

   Packages = https://github.com/sfadriaan/Salesforce/releases/latest/download/Salesforce.zip

   [*]
   BasedOnStyles = Salesforce
   ```

2. Download the package into your `StylesPath`:

   ```bash
   vale sync
   ```

3. Lint your content:

   ```bash
   vale README.md
   ```

To pin a specific version, replace `latest/download` with `download/<tag>`, for example `download/v0.1.0`.

## Scope

This package intentionally implements **only Salesforce-specific** guidance — product/feature names, Salesforce terminology, and forbidden or deprecated Salesforce terms. Generic writing mechanics (passive voice, Oxford comma, sentence length, and so on) are deliberately left out, because they are already covered by general-purpose packages such as [`Microsoft`](https://github.com/errata-ai/Microsoft), [`Google`](https://github.com/errata-ai/Google), or [`Datadog`](https://github.com/DataDog/vale-rules). Combine this package with one of those for full coverage:

```ini
BasedOnStyles = Salesforce, Microsoft
```

## Implemented Rules

Every rule links to the exact style-guide page it enforces (see the `link:` field in each `.yml`).

| Rule | What it enforces |
| --- | --- |
| `AppExchange` | Spell and capitalize *AppExchange* as one word. |
| `Application` | Use *Salesforce* rather than *application*/*app* for the product. |
| `BoldButtonText` | Use bold for button labels, e.g. Click **Save**. |
| `Checkbox` | *Checkbox* is one word. |
| `CustomerSupport` | Capitalize *Customer Support* and pair it with the company name. |
| `Databasecom` | Capitalize *Database.com* correctly. |
| `Datasheet` | *Datasheet* is one word. |
| `Deprecated` | Don't misuse *deprecated*; prefer *not supported*. |
| `Desupported` | Don't use *desupported*; prefer *no longer available*. |
| `Editions` | Capitalize both words of an edition name, e.g. *Enterprise Edition*. |
| `Hover` | Use *hover*, not *mouse over*. |
| `ListElementTypes` | Don't append element types like *button*/*link* after bold UI labels. |
| `ListViews` | Capitalize the *List View(s)* component. |
| `MouseTerminology` | Use *click*, not *click on*. |
| `Multitenant` | Spell *multitenant* as one word. |
| `ObjectManager` | Capitalize *Object Manager* and use the article *the*. |
| `Org` | Use *Salesforce org* / *org*, not *organization*. |
| `Picklist` | Spell *picklist* as one word. |
| `RichTextArea` | Capitalize the *Rich Text Area* component. |
| `SalesforceAdmin` | Use *Salesforce admin* (*Salesforce administrator* for UI/login text). |
| `SalesforceHelp` | Use *the Salesforce Help*. |
| `SelectCheckbox` | Use *select*/*deselect* for checkboxes. |
| `Subtab` | Spell *subtab* as one word. |
| `SupportAgent` | Use *support agent*. |
| `SystemAdministrator` | Use *Salesforce admin* (*Salesforce administrator* for UI/login text). |
| `Trailhead` | Spell and capitalize *Trailhead* correctly. |
| `Unavailable` | Describe UI states as *unavailable*/*disabled*, not *grayed out*/*dimmed*. |
| `Visualforce` | Spell and capitalize *Visualforce* correctly. |

## Repository Structure

<dl>
  <dt><a href="https://github.com/sfadriaan/Salesforce/tree/main/Salesforce"><code>/Salesforce</code></a></dt>
  <dd>The <a href="http://yaml.org/">YAML</a>-based rule implementations that make up our style.</dd>

  <dt><a href="https://github.com/sfadriaan/Salesforce/tree/main/fixtures"><code>/fixtures</code></a></dt>
  <dd>The individual unit tests. Each directory should be named after a rule found in <code>/Salesforce</code> and include its own <code>.vale.ini</code> file that isolates its target rule.</dd>

  <dt><a href="https://github.com/sfadriaan/Salesforce/tree/main/features"><code>/features</code></a></dt>
  <dd>The <a href="https://docs.cucumber.io/cucumber/step-definitions/">Cucumber Step Definitions</a> we use to test our fixtures.</dd>
</dl>

## Development and Testing

The [`Makefile`](Makefile) creates a virtual environment and installs Vale, [Behave](https://behave.readthedocs.io/), and [PyMarkdown](https://github.com/jackdewinter/pymarkdown) from [`requirements.txt`](requirements.txt).

```bash
make install       # create the venv and install dependencies (run once)
make run-behave    # run the full test suite (the CI gate)
make vale-verbose  # run Vale across the repo
make lint-md       # Markdown-lint the fixtures
```

Both `make run-behave` and `make lint-md` run in [CI](.github/workflows/run-behave.yml) on every pull request and on pushes to `main`.

## Contributing

Each rule touches three places: a definition in `/Salesforce`, a fixture in `/fixtures`, and a scenario in [`features/rules.feature`](features/rules.feature). See [`AGENTS.md`](AGENTS.md) for the full per-rule workflow and conventions. In short:

1. Add `Salesforce/<RuleName>.yml` with an `extends`, a `message`, and a `link:` to the style-guide page it enforces.
2. Add `fixtures/<RuleName>/vale.ini` and a `test.md` that triggers the rule a known number of times.
3. Add a `Scenario` to `features/rules.feature`.
4. Run `make run-behave` and `make lint-md` until both pass, then open a pull request.

## Releasing

Pushing a version tag builds the package and publishes it as a GitHub Release asset (`Salesforce.zip`), which is what `vale sync` downloads:

```bash
git tag v0.1.0
git push origin v0.1.0
```

See [`.github/workflows/release.yml`](.github/workflows/release.yml).


<dl>
  <dt><a href="https://github.com/sfadriaan/Salesforce/tree/main/Salesforce"><code>/Salesforce</code></a></dt>
  <dd>The <a href="http://yaml.org/">YAML</a>-based rule implementations that make up our style.</dd>

  <dt><a href="https://github.com/sfadriaan/Salesforce/tree/main/fixtures"><code>/fixtures</code></a></dt>
  <dd>The individual unit tests. Each directory should be named after a rule found in <code>/Salesforce</code> and include its own <code>.vale.ini</code> file that isolates its target rule.</dd>

  <dt><a href="https://github.com/sfadriaan/Salesforce/tree/main/features"><code>/features</code></a></dt>
  <dd>The <a href="https://docs.cucumber.io/cucumber/step-definitions/">Cucumber Step Definitions</a> we use to test our fixtures.</dd>
</dl>