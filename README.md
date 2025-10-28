# Salesforce

> **NOTE**: This project is neither maintained nor endorsed by Salesforce.

This repository contains a [Vale-compatible](https://github.com/errata-ai/vale) implementation of the [*Salesforce Writing Style Guide*](https://developer.salesforce.com/docs/atlas.en-us.salesforce_pubs_style_guide.meta/salesforce_pubs_style_guide/overview.htm) ([LICENSE](https://www.salesforce.com/company/legal/)).

## Getting Started

To get started, add the package to your configuration file (as shown below) and then run `vale sync`.

```ini
StylesPath = styles
MinAlertLevel = suggestion

Packages = Salesforce

[*]
BasedOnStyles = Vale, Salesforce
```

## Repository Structure

<dl>
  <dt><a href="https://github.com/sfadriaan/Salesforce/tree/main/Salesforce"><code>/Salesforce</code></a></dt>
  <dd>The <a href="http://yaml.org/">YAML</a>-based rule implementations that make up our style.</dd>

  <dt><a href="https://github.com/sfadriaan/Salesforce/tree/main/fixtures"><code>/fixtures</code></a></dt>
  <dd>The individual unit tests. Each directory should be named after a rule found in <code>/Salesforce</code> and include its own <code>.vale.ini</code> file that isolates its target rule.</dd>

  <dt><a href="https://github.com/sfadriaan/Salesforce/tree/main/features"><code>/features</code></a></dt>
  <dd>The <a href="https://docs.cucumber.io/cucumber/step-definitions/">Cucumber Step Definitions</a> we use to test our fixtures.</dd>
</dl>