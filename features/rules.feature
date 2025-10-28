Feature: Rules

Scenario: Salesforce administrator language
    When I test "SalesforceAdmin"
    Then the linter output should report the following issues:
        | File | Line | Rule | Message |
        | test.md | 11 | Salesforce.SalesforceAdmin | Use 'Salesforce admin' instead of 'admin'. Note: For UI text and login documentation, use 'Salesforce administrator'. |
        | test.md | 13 | Salesforce.SalesforceAdmin | Use 'Salesforce admin' instead of 'admin'. Note: For UI text and login documentation, use 'Salesforce administrator'. |
        | test.md | 13 | Salesforce.SalesforceAdmin | Use 'Salesforce admin' instead of 'admin'. Note: For UI text and login documentation, use 'Salesforce administrator'. |