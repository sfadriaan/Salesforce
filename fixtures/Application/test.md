We discovered that the primary issue lies with the outdated integration module. 
When a user attempts to update a large record set, the module fails to properly authenticate with the target environment, causing a timeout. 
To resolve this, we must upgrade the legacy module responsible for transmitting data to the **Salesforce application**. 
The development team is currently prioritizing the migration away from this older system to ensure full compliance and stable data exchange with the main Salesforce instance.