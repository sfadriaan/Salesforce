Feature: Rules

Scenario: Salesforce administrator language
    When I test "SalesforceAdmin"
    Then the linter output should report the following issues:
        | File | Line | Rule | Message |
        | test.md | 11 | Salesforce.SalesforceAdmin | Use 'Salesforce admin' instead of 'admin'. Note: For UI text and login documentation, use 'Salesforce administrator'.|
        | test.md | 13 | Salesforce.SalesforceAdmin | Use 'Salesforce admin' instead of 'admin'. Note: For UI text and login documentation, use 'Salesforce administrator'.|
        | test.md | 13 | Salesforce.SalesforceAdmin | Use 'Salesforce admin' instead of 'admin'. Note: For UI text and login documentation, use 'Salesforce administrator'.|

Scenario: Salesforce application language
    When I test "Application"
    Then the linter output should report the following issues:
        | File | Line | Rule | Message |
        | test.md | 3 | Salesforce.Application | Use 'Salesforce' instead of 'Salesforce application'.|

Scenario: Button Label Should Be Bold
    When I test "BoldButtonText"
    Then the linter output should report the following issues:
        | File | Line | Rule | Message |
        | test.md | 5 | Salesforce.BoldButtonText | Use bold text when referring to buttons, such as Click **Save**.|
        | test.md | 6 | Salesforce.BoldButtonText | Use bold text when referring to buttons, such as Click **Save**.|
        | test.md | 7 | Salesforce.BoldButtonText | Use bold text when referring to buttons, such as Click **Save**.|
        | test.md | 8 | Salesforce.BoldButtonText | Use bold text when referring to buttons, such as Click **Save**.|
        | test.md | 9 | Salesforce.BoldButtonText | Use bold text when referring to buttons, such as Click **Save**.|
        | test.md | 10 | Salesforce.BoldButtonText | Use bold text when referring to buttons, such as Click **Save**.|
        | test.md | 11 | Salesforce.BoldButtonText | Use bold text when referring to buttons, such as Click **Save**.|

Scenario: List UI Element Types
    When I test "ListElementTypes"
    Then the linter output should report the following issues:
        | File | Line | Rule | Message |
        | test.md | 5 | Salesforce.ListElementTypes | Write 'click **Save**', not 'click the **Save** button'. Similarly, do not write 'Click the Login button'.|
        | test.md | 6 | Salesforce.ListElementTypes | Write 'click **Save**', not 'click the **Save** button'. Similarly, do not write 'click the Submit button'.|
        | test.md | 7 | Salesforce.ListElementTypes | Write 'click **Save**', not 'click the **Save** button'. Similarly, do not write 'click the Finish button'.|
        | test.md | 8 | Salesforce.ListElementTypes | Write 'click **Save**', not 'click the **Save** button'. Similarly, do not write 'click the Save button'.|
        | test.md | 9 | Salesforce.ListElementTypes | Write 'click **Save**', not 'click the **Save** button'. Similarly, do not write 'click the Cancel button'.|

Scenario: Checkox is one word
    When I test "Checkbox"
    Then the linter output should report the following issues:
        | File | Line | Rule | Message |
        | test.md | 1 | Salesforce.Checkbox | 'Checkbox' is one word.|

Scenario: Select/Deselect Checkbox
    When I test "SelectCheckbox"
    Then the linter output should report the following issues:
        | File | Line | Rule | Message |
        | test.md | 5 | Salesforce.SelectCheckbox | Use 'select' or 'deselect' when referring to a checkbox. Avoid verbs like 'check the checkbox'. |
        | test.md | 6 | Salesforce.SelectCheckbox | Use 'select' or 'deselect' when referring to a checkbox. Avoid verbs like 'uncheck the disable feature checkbox'. |
        | test.md | 7 | Salesforce.SelectCheckbox | Use 'select' or 'deselect' when referring to a checkbox. Avoid verbs like 'Mark the NPS checkbox'. |
        | test.md | 8 | Salesforce.SelectCheckbox | Use 'select' or 'deselect' when referring to a checkbox. Avoid verbs like 'tick the checkbox'. |
        | test.md | 8 | Salesforce.SelectCheckbox | Use 'select' or 'deselect' when referring to a checkbox. Avoid verbs like 'untick the checkbox'. |

Scenario: Select/Deselect Checkbox
    When I test "CustomerSupport"
    Then the linter output should report the following issues:
        | File | Line | Rule | Message |
        | test.md | 5 | Salesforce.CustomerSupport | Capitalize 'Customer Support' and use it with the company name, for example 'Salesforce Customer Support'. |
        | test.md | 6 | Salesforce.CustomerSupport | Capitalize 'Customer Support' and use it with the company name, for example 'Salesforce Customer Support'. |
        | test.md | 7 | Salesforce.CustomerSupport | Capitalize 'Customer Support' and use it with the company name, for example 'Salesforce Customer Support'. |
        | test.md | 8 | Salesforce.CustomerSupport | Capitalize 'Customer Support' and use it with the company name, for example 'Salesforce Customer Support'. |

Scenario: Picklist is one word
    When I test "Picklist"
    Then the linter output should report the following issues:
        | File | Line | Rule | Message |
        | test.md | 5 | Salesforce.Picklist | Use 'picklist' (one word) instead of 'pick list'. |
        | test.md | 6 | Salesforce.Picklist | Use 'picklist' (one word) instead of 'pick-list'. |
        | test.md | 7 | Salesforce.Picklist | Use 'picklist' (one word) instead of 'pick lists'. |

Scenario: Org not organization
    When I test "Org"
    Then the linter output should report the following issues:
        | File | Line | Rule | Message |
        | test.md | 5 | Salesforce.Org | Use 'Salesforce org' (or 'org') instead of 'organization'. |
        | test.md | 6 | Salesforce.Org | Use 'Salesforce org' (or 'org') instead of 'organizations'. |

Scenario: Multitenant is one word
    When I test "Multitenant"
    Then the linter output should report the following issues:
        | File | Line | Rule | Message |
        | test.md | 5 | Salesforce.Multitenant | Spell 'multitenant' as one word instead of 'multi-tenant'. |
        | test.md | 6 | Salesforce.Multitenant | Spell 'multitenant' as one word instead of 'multi tenant'. |

Scenario: Subtab is one word
    When I test "Subtab"
    Then the linter output should report the following issues:
        | File | Line | Rule | Message |
        | test.md | 5 | Salesforce.Subtab | Spell 'subtab' as one word instead of 'sub-tab'. |
        | test.md | 6 | Salesforce.Subtab | Spell 'subtab' as one word instead of 'sub tabs'. |

Scenario: System administrator wording
    When I test "SystemAdministrator"
    Then the linter output should report the following issues:
        | File | Line | Rule | Message |
        | test.md | 5 | Salesforce.SystemAdministrator | Use 'Salesforce admin' instead of 'system administrator'. Note: Use 'Salesforce administrator' for UI text and login documentation. |
        | test.md | 6 | Salesforce.SystemAdministrator | Use 'Salesforce admin' instead of 'system administrators'. Note: Use 'Salesforce administrator' for UI text and login documentation. |

Scenario: Object Manager capitalization
    When I test "ObjectManager"
    Then the linter output should report the following issues:
        | File | Line | Rule | Message |
        | test.md | 5 | Salesforce.ObjectManager | Capitalize 'Object Manager' (and use the article 'the') instead of 'object manager'. |
        | test.md | 6 | Salesforce.ObjectManager | Capitalize 'Object Manager' (and use the article 'the') instead of 'Object manager'. |

Scenario: Support agent wording
    When I test "SupportAgent"
    Then the linter output should report the following issues:
        | File | Line | Rule | Message |
        | test.md | 5 | Salesforce.SupportAgent | Use 'support agent' instead of 'support rep'. |
        | test.md | 6 | Salesforce.SupportAgent | Use 'support agent' instead of 'support representative'. |
        | test.md | 7 | Salesforce.SupportAgent | Use 'support agent' instead of 'customer support representative'. |
        | test.md | 8 | Salesforce.SupportAgent | Use 'support agent' instead of 'customer support agent'. |

Scenario: Salesforce Help naming
    When I test "SalesforceHelp"
    Then the linter output should report the following issues:
        | File | Line | Rule | Message |
        | test.md | 5 | Salesforce.SalesforceHelp | Use 'the Salesforce Help' instead of 'online help'. |
        | test.md | 6 | Salesforce.SalesforceHelp | Use 'the Salesforce Help' instead of 'Salesforce help'. |

Scenario: Deprecated term usage
    When I test "Deprecated"
    Then the linter output should report the following issues:
        | File | Line | Rule | Message |
        | test.md | 5 | Salesforce.Deprecated | Don't use 'deprecated' for a feature that's available but no longer supported. Use 'not supported' instead. |
        | test.md | 6 | Salesforce.Deprecated | Don't use 'deprecated' for a feature that's available but no longer supported. Use 'not supported' instead. |

Scenario: Desupported term usage
    When I test "Desupported"
    Then the linter output should report the following issues:
        | File | Line | Rule | Message |
        | test.md | 5 | Salesforce.Desupported | Don't use 'desupported' for a removed feature. Use 'no longer available' instead. |
        | test.md | 6 | Salesforce.Desupported | Don't use 'desupported' for a removed feature. Use 'no longer available' instead. |

Scenario: Edition name capitalization
    When I test "Editions"
    Then the linter output should report the following issues:
        | File | Line | Rule | Message |
        | test.md | 5 | Salesforce.Editions | Capitalize both words in an edition name, for example 'Enterprise Edition'. Found 'Enterprise edition'. |
        | test.md | 6 | Salesforce.Editions | Capitalize both words in an edition name, for example 'Enterprise Edition'. Found 'Group edition'. |

Scenario: Datasheet one word
    When I test "Datasheet"
    Then the linter output should report the following issues:
        | File | Line | Rule | Message |
        | test.md | 5 | Salesforce.Datasheet | 'datasheet' is one word. Don't split it into two words. |
        | test.md | 6 | Salesforce.Datasheet | 'datasheets' is one word. Don't split it into two words. |

Scenario: Rich Text Area component capitalization
    When I test "RichTextArea"
    Then the linter output should report the following issues:
        | File | Line | Rule | Message |
        | test.md | 5 | Salesforce.RichTextArea | 'rich text area' is a Salesforce component. Capitalize it as 'Rich Text Area'. |
        | test.md | 6 | Salesforce.RichTextArea | 'rich text area' is a Salesforce component. Capitalize it as 'Rich Text Area'. |

Scenario: List Views component capitalization
    When I test "ListViews"
    Then the linter output should report the following issues:
        | File | Line | Rule | Message |
        | test.md | 5 | Salesforce.ListViews | 'list view' is a Salesforce component. Capitalize it, for example 'List View' or 'List Views'. |
        | test.md | 6 | Salesforce.ListViews | 'list views' is a Salesforce component. Capitalize it, for example 'List View' or 'List Views'. |

Scenario: Hover instead of mouse over
    When I test "Hover"
    Then the linter output should report the following issues:
        | File | Line | Rule | Message |
        | test.md | 5 | Salesforce.Hover | Use 'hover' to describe moving the pointer over an element, not 'mouse over'. |
        | test.md | 6 | Salesforce.Hover | Use 'hover' to describe moving the pointer over an element, not 'mouse over'. |

Scenario: Unavailable UI state wording
    When I test "Unavailable"
    Then the linter output should report the following issues:
        | File | Line | Rule | Message |
        | test.md | 5 | Salesforce.Unavailable | Don't use 'grayed out' for a UI state. Use 'unavailable' or 'disabled' instead. |
        | test.md | 6 | Salesforce.Unavailable | Don't use 'dimmed' for a UI state. Use 'unavailable' or 'disabled' instead. |
        | test.md | 7 | Salesforce.Unavailable | Don't use 'uneditable' for a UI state. Use 'unavailable' or 'disabled' instead. |

Scenario: Click instead of click on
    When I test "MouseTerminology"
    Then the linter output should report the following issues:
        | File | Line | Rule | Message |
        | test.md | 5 | Salesforce.MouseTerminology | Don't use 'Click on'. Use 'click' instead. |
        | test.md | 6 | Salesforce.MouseTerminology | Don't use 'click on'. Use 'click' instead. |

Scenario: AppExchange name capitalization
    When I test "AppExchange"
    Then the linter output should report the following issues:
        | File | Line | Rule | Message |
        | test.md | 5 | Salesforce.AppExchange | Use 'AppExchange' (one word, capital A and E) instead of 'App Exchange'. |
        | test.md | 6 | Salesforce.AppExchange | Use 'AppExchange' (one word, capital A and E) instead of 'appexchange'. |
        | test.md | 7 | Salesforce.AppExchange | Use 'AppExchange' (one word, capital A and E) instead of 'Appexchange'. |

Scenario: Visualforce name capitalization
    When I test "Visualforce"
    Then the linter output should report the following issues:
        | File | Line | Rule | Message |
        | test.md | 5 | Salesforce.Visualforce | Use 'Visualforce' instead of 'VisualForce'. |
        | test.md | 6 | Salesforce.Visualforce | Use 'Visualforce' instead of 'Visual Force'. |
        | test.md | 7 | Salesforce.Visualforce | Use 'Visualforce' instead of 'visualforce'. |

Scenario: Trailhead name capitalization
    When I test "Trailhead"
    Then the linter output should report the following issues:
        | File | Line | Rule | Message |
        | test.md | 5 | Salesforce.Trailhead | Use 'Trailhead' instead of 'Trail Head'. |
        | test.md | 6 | Salesforce.Trailhead | Use 'Trailhead' instead of 'TrailHead'. |
        | test.md | 7 | Salesforce.Trailhead | Use 'Trailhead' instead of 'trailhead'. |

Scenario: Database.com name capitalization
    When I test "Databasecom"
    Then the linter output should report the following issues:
        | File | Line | Rule | Message |
        | test.md | 5 | Salesforce.Databasecom | Use 'Database.com' instead of 'database.com'. |
        | test.md | 6 | Salesforce.Databasecom | Use 'Database.com' instead of 'Database.Com'. |
        | test.md | 7 | Salesforce.Databasecom | Use 'Database.com' instead of 'DataBase.com'. |