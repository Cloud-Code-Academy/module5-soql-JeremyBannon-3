/**
* The SOQL class serves as a primer into the Salesforce Object Query Language in Apex.
* It covers fundamental aspects such as SELECT statements, WHERE clauses, Relationship queries, and LIMIT keyword.
*
* This class introduces developers to the concept of retrieving data from Salesforce using SOQL. It provides
* a step-by-step guide on how to construct SOQL queries, filter results using WHERE clause, retrieve related
* records, and manage data volume using the LIMIT keyword.
* 
* Topics covered in this class include:
* - Understanding the structure of a SOQL query.
* - Crafting basic SELECT statements in SOQL.
* - Applying filters using the WHERE clause in SOQL.
* - Fetching related records using Relationship queries.
* - Controlling the amount of data retrieved using the LIMIT keyword.
* 
* Users of this class can expect to gain a solid understanding of SOQL in Apex and
* be prepared to handle data retrieval tasks in Salesforce development.
* 
* @author Jeremy Bannon
*/

public with sharing class SOQL {
    
    /**
     * Question 1
     * Update/Uncomment the template code to create a method
     * Returns all leads from Salesforce Org
     * @return List of all leads with Id, LastName, Company, Phone, Email
     * Update the corresponding test class and testGetAllLeads method to cover this method
     */
    public static List<Lead> getAllLeads () {
        List<Lead> leads = [SELECT Id, LastName, Company, Phone, Email FROM Lead];
        return leads;
    //  The body of the method
    }

    /**
     * Question 2
     * Update/Uncomment the template code to create a method
     * Returns all contacts with first name of John.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByFirstName method to cover this method
     */
    public static  List<Contact> getContactsByFirstName () {
        List<Contact> contacts = [SELECT Id, Name, FirstName, LastName FROM Contact WHERE FirstName = 'John'];
        return contacts;
    //  The body of the method
    }

    /**
     * Question 3
     * Update/Uncomment the template code to create a method
     * Returns the Contact Id for all contacts with last name of Smith or Jones
     * @return A list of Contact Ids.
     * Update the corresponding test class and testGetContactIdsByLastName method to cover this method
     */
    public static List<Id> getContactIdsByLastName () {
        List<Contact> contacts = [SELECT Id FROM Contact WHERE LastName = 'Smith' OR LastName = 'Jones'];
        List<Id> contactIds = new List<Id>();
        for(Contact con : contacts ){
            contactIds.add(con.Id);
        }
        return contactIds;
    //  The body of the method
    }

    /**
     * Question 4
     * Update/Uncomment the template code to create a method
     * Returns List of closed won opportunities for a specific Account.
     * Example: yourMethodName('001XXXXXXXXXXXX') should return the list of closed won opportunities for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Opportunities with important opportunities fields
     * Update the corresponding test class and testGetClosedWonOpportunityCountByAccount method to cover this method
     */
    public  static List<Opportunity> getClosedWonOpportunityCountByAccount (String accountId) {
        //  The body of the method
        List<Opportunity> opp = [SELECT Id, Name, Amount, StageName, CloseDate, AccountId FROM Opportunity WHERE StageName = 'Closed Won' AND AccountId = :accountId];
    
        return opp;
    
    }

    /**
     * Question 5
     * Update/Uncomment the template code to create a method
     * Returns the total count of Account records.
     * @return The Integer count of Account records.
     * Update the corresponding test class and testGetAccountCount method to cover this method
     */
    public static Integer getAccountCount() {
    //  The body of the method
        Integer numberOfAccounts = [SELECT COUNT() FROM Account];
        return numberOfAccounts;   
    }

    /**
     * Question 6
     * Update/Uncomment the template code to create a method
     * Return Key Value pair of Task Id and Task records for any tasks due date within the next 7 days.
     * @return A map of Task Ids to Task records.
     * Update the corresponding test class and testGetTasksDueNextWeek method to cover this method
     */
    public static Map<Id, Task> getTasksDueNextWeek () {
        //  The body of the method
        List<Task> upcomingTasks = [SELECT Id, Subject, ActivityDate FROM Task WHERE ActivityDate = NEXT_N_DAYS:7];
        
        Map<Id, Task> upcoming = new Map<Id, Task>();

        for(Task t : upcomingTasks){
            upcoming.put(t.Id, t);
        }
        return upcoming;
    }
    /**
     * Question 7
     * Update/Uncomment the template code to create a method
     * Retrieves all Contacts that have a example.com domain in their Email.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
     */
    public static List<Contact> getContactsByEmailDomain (){
        // The body of the method
        List<Contact> con = [SELECT Id, Name, Email FROM Contact WHERE Email LIKE '%example.com'];
        return con;
    }
    /**
     * Question 8
     * Retrieves all Opportunities that have a specific keyword in their Name.
     * Example: getOpportunitiesByNameKeyword('keyword') should return all Opportunities that have 'keyword' in their Name.
     * @param keyword The keyword to search for in the Opportunity Name.
     * @return A list of Opportunity records.
     */
    public static List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {
        List<Opportunity> opp =[SELECT Id, Name FROM Opportunity WHERE Name LIKE :('%' + keyword + '%')];    
    
        return opp; // Replace null with the variable you used to store the result
    }

    /**
     * Question 9
     * Retrieves all Cases that Case Origin is not Web or Email or Blank
     * @return A list of Case records.
     */
    public static List<Case> getFilterCaseOrigins() {
        List<Case> cList = [SELECT Id, Subject, Origin FROM Case WHERE Origin NOT IN ('Web', 'Email', '')];

        return cList; // Replace null with the variable you used to store the result
    }

    /**
     * Question 10
     * Update/Uncomment the template code to create a method
     * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
     * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
     * @param leadSource The Lead Source to search for.
     * @param keyword The keyword to search for in the Lead Title.
     * @return A list of Lead records.
     * Update the corresponding test class and testGetLeadsBySourceOrTitle method to cover this method
     */
    public static List<Lead> getLeadsBySourceOrTitle() {
        List<Lead> leads = [SELECT Id, Company, Phone, Email, LastName, Title, LeadSource FROM Lead WHERE LeadSource = 'Web' OR Title LIKE '%Engineer%'];

        return leads; 
    }    

    /**
     * Question 11
     * Returns the names of all Contacts associated with an Account.
     * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Contact LastName.
     */
    public static List<String> getContactNamesByAccount(Id accountId) {

        // Create a list to hold the Contact LastNames
    List<String> lastNameList = new List<String>();
        // Query the Contacts
    List<Contact> con = [SELECT Id, FirstName, LastName, AccountId FROM Contact WHERE AccountId = :accountId];
        // Loop through each Contact and add the LastName to the list
    for (Contact c : con) {  
        lastNameList.add(c.LastName);
    }

        // Return the list of Contact LastNames
    return lastNameList; // Replace null with the variable you used to store the result
}


    /**
     * Question 12
     * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10000.
     * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for all Opportunities in the 'Closed Won' Stage.
     * @param stage The Stage value to filter Opportunities.
     * @return The total revenue.
     */
    public static Decimal getTotalRevenueByStage(String stage) {
        AggregateResult[] totalRevenue = [SELECT SUM(Amount) totalAmount FROM Opportunity WHERE StageName = :stage OR Amount > 10000];
           // Use AggregateQuery to get the total revenue
        Decimal revenue = (Decimal)totalRevenue[0].get('totalAmount');
           // Return the total revenue
        return revenue; // Replace null with the variable you used to store the result
}

    /**
     * Question 13
     * Retrieves the first 10 Accounts ordered by Name.
     * @return A list of the first 10 Accounts ordered by Name.
     */
    public static List<Account> getFirstTenAccounts() {
        Account[] accounts = [SELECT Id, Name FROM Account ORDER BY Name LIMIT 10];

        return accounts; // Replace null with the variable you used to store the result
    }
    
    /**
     * Question 14
     * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     */
    public static List<Opportunity> getHighValueOpportunities() {
        Opportunity[] opps = [SELECT Id, Name, Amount, CloseDate FROM Opportunity WHERE Amount > 100000 ORDER BY CloseDate Limit 5];

        return opps; // Replace null with the variable you used to store the result
    }
    
    /**
     * Question 15
     * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
     * @return A list of Contacts
     */
    public static List<Contact> getBirthdateContacts() {
        Contact[] contactBirthday = [SELECT Id, Name, Birthdate FROM Contact ORDER BY Birthdate DESC NULLS LAST LIMIT 3];

        return contactBirthday; // Replace null with the variable you used to store the result
    }
    
    /**
     * Question 16
     * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
     * @return A list of Cases
     */
    public static List<Case> getCasesWithStatus() {
        Case[] cases = [SELECT Id, Status, Subject, CreatedDate FROM Case WHERE Status = 'Open' ORDER BY CreatedDate LIMIT 10 OFFSET 5];

       return cases; // Replace null with the variable you used to store the result
    }

    /**
     * Question 17
     * Returns Set of Case Ids for a specific Account.
     * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A set of Case Ids.
     */
    public static Set<Id> getCaseIdsByAccount(Id accountId) {
        // Create a set to hold the Case Ids
    Set<Id> setOfCases = new Set<Id>();
        // Query the Cases
    Case[] cases = [SELECT Id, AccountId FROM Case WHERE AccountId = :accountId];
        // Loop through each Case and add the Id to the set
    for (Case c : cases) {
        setOfCases.add(c.Id);

    }

        return setOfCases; // Replace null with the variable you used to store the result
}

    /**
     * Question 18
     * Return Map of Account Ids to Account Names Not in a specific Country.
     * Example: getAccountIdsToNamesNotInCountry('United States') should return the map of Account Ids to Account Names for Accounts that are not in the United States.
     * @param country The country to filter Accounts.
     * @return A map of Account Ids to Account Names.
     */
    public static Map<Id, String> getAccountIdsToNamesNotInCountry(String country) {
        Map<Id, String> accountIdsToNames = new Map<Id, String>();

        Account[] accounts = [SELECT Id, Name, BillingCountry FROM Account WHERE BillingCountry != 'Canada'];
        System.debug('accounts: ' + accounts);

        for(Account a : accounts){
            accountIdsToNames.put(a.Id, a.Name);
        }
        return accountIdsToNames;
}
    /**
     * Question 19
     * Retrieves the Account Name for a given Contact.
     * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
     * @param contactId The Id of the Contact.
     * @return The Account Name of the Contact.
     */
    public static String getAccountNameForContact(String contactId) {
        Contact[] contacts = [SELECT Id, Name, Account.Name FROM Contact WHERE Id = :contactId];

        if(contacts != null){
        return contacts[0].Account.Name;
        }
        
        return null;
    }   

    /**
     * Question 20
     * Returns single Account that has related opportunities in the same query
     * Example: getAccountAndOpportunitiesFromAccountId('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
     * @param accountId The ID of the Account.
     * @return An Account record with related Opportunities.
     */
    public static Account getAccountAndOpportunitiesFromAccountId(Id accountId) {
        Account[] accounts = [SELECT Id, Name,(SELECT Id, Name FROM Opportunities) FROM Account WHERE Id = :accountId];

        if(accounts !=null){

        return accounts[0];
        }


        return null; // Replace null with the variable you used to store the result
    }

    /**
     * Question 21
     * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
     * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts that have the same Mailing State as the Account with the Id
     * @param Account Id
     * @return List of contacts with the same Mailing State as the Account Billing State
     */
    public static List<Contact> getAccountsWithContactsByState(Id accountId) {
        
        Account[] accounts = [SELECT Id, Name, BillingState FROM Account WHERE Id = :accountId ];
        
        String billingState = accounts[0].BillingState;
        
        Contact[] contacts = [SELECT Id, Name, MailingState FROM Contact WHERE MailingState = :billingState];
    
        return contacts;
        
    }
    /**
     * Question 22
     * Extracts email domains from them leads, then finds Accounts with matching website domains
     * If Lead Email = test@test.com return account with website = www.test.com
     * Example: findAccountsByLeadEmailDomains([set of lead ids]) should return a list of Accounts with matching email domains
     * @param A set of Lead Ids.
     * @return A list of Accounts with matching email domains.
     */
    public static List<Account> findAccountsByLeadEmailDomains(Set<Id> leadIds) {
        // Query the Leads
        Lead[] leads = [SELECT Id, Email FROM Lead WHERE Id IN :leadIds];
        
        // Create a set of email domains from the Leads
        Set<String> domains = new Set<String>();
        
        // Loop through each Lead
        for (Lead l : leads) {
            // Check if the email is not null and contains an '@'
            if (l.Email != null && l.Email.contains('@')) {
                String[] split = l.Email.split('@');
                if (split.size() > 1) {
                    // Add the email domain to the set, converted to lowercase
                    domains.add(split[1].toLowerCase());
                }
            }
        }
        
        // Query the Accounts (without trying to manipulate the website in SOQL)
        List<Account> allAccounts = [SELECT Id, Website FROM Account];
        List<Account> matchedAccounts = new List<Account>();
        
        // Normalize the website domain by stripping 'www.' and making it lowercase, then match with domains
        for (Account acc : allAccounts) {
            if (acc.Website != null) {
                // Strip 'www.' if present and convert to lowercase
                String normalizedWebsite = acc.Website.replace('www.', '').toLowerCase();
                if (domains.contains(normalizedWebsite)) {
                    matchedAccounts.add(acc);
                }
            }
        }
        
        // Return the list of matched Accounts
        return matchedAccounts;
    }
    
    
    
    /**
     * Question 23
     * Clones and Inserts Opportunity Line Items from an original Opportunity to a list of cloned Opportunities.
     * Adds a randomized number between 1 to 3 to the quantity of each line item.
     * Example: cloneLineItems('001XXXXXXXXXXXX', [list of opportunity ids]) should clone the line items from the Opportunity with the Id to each Opportunity in the list
     * @param Original Opportunity Id
     * @param List of cloned Opportunity Ids
     */
    public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {
        // Query the original Opportunity Line Items
    OpportunityLineItem[] olis = [SELECT Id, Name, Quantity, UnitPrice, PricebookEntryId FROM OpportunityLineItem WHERE OpportunityId = :origOppId];
        // Create a list to hold the new line items
    List<OpportunityLineItem> oliNew = new List<OpportunityLineItem>();
        // Generate a random number between 1 and 3
     
        // Loop through each cloned Opportunity Id
    for(Id cloneOppId : cloneOppIds){

    
            // Loop through each original line item
            for(OpportunityLineItem oli : olis){
            OpportunityLineItem newOli = oli.clone(false, false, false, false);
            Integer randomAddition = Integer.valueOf(Math.round(Math.random() * 2)) + 1; 
            newOli.Quantity = oli.Quantity + randomAddition;
            newOli.OpportunityId = cloneOppId;
            oliNew.add(newOli);
            }
                // Clone the original line item and add the random number to the quantity
        }
        Insert oliNew;
}
    
    /**
     * Question 24
     * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
     * Example: getOpportunityDetailsForClosedWon()
     * @return A list of filtered Opportunity
     */
    public static List<Opportunity> getOpportunityDetailsForClosedWon() {  
        
        Opportunity[] opps = [SELECT Id, Name, Account.Name, Owner.Name FROM Opportunity WHERE StageName = 'Closed Won'];

        return opps; // Replace null with the variable you used to store the result
    }

    /**
     * Question 25
     * Sets the 'Primary_Contact__c' field for all Closed Won Opportunities to first Contact on the Account.
     * Example: setPrimaryContact() should set the 'Primary_Contact__c' field for every Opportunity in the org
     */
    public static void setPrimaryContact() {
        //Use the getOpportunityDetailsForClosedWon() method to get the Opportunities
    List<Opportunity> opps = SOQL.getOpportunityDetailsForClosedWon();
        // Create a set of Account Ids from the Opportunities
    Set<Id> accIds = new Set<Id>();
    for(Opportunity o : opps) {
            accIds.add(o.AccountId);
    }
        // Query the Contacts
    List<Contact> contacts = [SELECT Id, AccountId FROM Contact WHERE AccountId IN :accIds];
        // Create a map of Account Ids to Contacts
    Map<Id, Contact> accountToContactMap = new Map<Id, Contact>();
        // Loop through each Contact and add the Account Id and Contact to the map
    for(Contact c : contacts) {
            accountToContactMap.put(c.AccountId, c);
        // Loop through each Opportunity
    
        for(Opportunity o : opps) {
                // Update the Opportunity primary contact from accountToContactMap
            o.Primary_Contact__c = accountToContactMap.get(o.AccountId).Id;
    }
}
    Update opps;
}
}