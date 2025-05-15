@isTest
public class ContactTriggerHandlerTest {
    static Account testAccount;
    static List<Contact> testContacts;

    @testSetup
    static void setup() {
        // Create an Account for the tests
        testAccount = new Account(Name = 'Test Account', Count_Contact__c = 0); // Initialize Count_Contact__c
        insert testAccount;

        // Create Contacts associated with the Account
        testContacts = new List<Contact>{
            new Contact(FirstName = 'John', LastName = 'Doe', AccountId = testAccount.Id),
            new Contact(FirstName = 'Jane', LastName = 'Doe', AccountId = testAccount.Id)
        };
        insert testContacts;
    }

    @isTest
    static void testContactInsert() {
        // Create a new contact to trigger the insertion logic
        Contact newContact = new Contact(FirstName = 'Tom', LastName = 'Smith', AccountId = testAccount.Id);
        insert newContact;

        // Re-query the Account to verify the Count_Contact__c value
        Account accountAfterInsert = [SELECT Id, Count_Contact__c FROM Account WHERE Id = :testAccount.Id];

        // Assert the Count_Contact__c field should be 3 after inserting the new Contact
        System.assertEquals(3, accountAfterInsert.Count_Contact__c, 'Count_Contact__c should be 3 after inserting a contact');
    }

    @isTest
    static void testContactUpdate() {
        // Update the first Contact
        Contact contactToUpdate = testContacts[0];
        contactToUpdate.LastName = 'Doe Updated';
        update contactToUpdate;

        // Re-query the Account to verify Count_Contact__c remains the same
        Account accountAfterUpdate = [SELECT Id, Count_Contact__c FROM Account WHERE Id = :testAccount.Id];

        // Assert the Count_Contact__c field should still be 2 after updating the Contact
        System.assertEquals(2, accountAfterUpdate.Count_Contact__c, 'Count_Contact__c should still be 2 after updating a contact');
    }

    @isTest
    static void testContactDelete() {
        // Delete the first Contact
        Contact contactToDelete = testContacts[0];
        delete contactToDelete;

        // Re-query the Account to verify Count_Contact__c value
        Account accountAfterDelete = [SELECT Id, Count_Contact__c FROM Account WHERE Id = :testAccount.Id];

        // Assert the Count_Contact__c field should now be 1 after deleting the Contact
        System.assertEquals(1, accountAfterDelete.Count_Contact__c, 'Count_Contact__c should be 1 after deleting a contact');
    }

    @isTest
    static void testContactUndelete() {
        // Delete the first Contact first to then undelete it
        Contact contactToDelete = testContacts[0];
        delete contactToDelete;

        // Undelete the Contact
        Database.UndeleteResult undeleteResult = Database.undelete(contactToDelete.Id, false);
        System.assert(undeleteResult.isSuccess(), 'Undelete should be successful');

        // Re-query the Account to verify Count_Contact__c value
        Account accountAfterUndelete = [SELECT Id, Count_Contact__c FROM Account WHERE Id = :testAccount.Id];

        // Assert the Count_Contact__c field should be back to 2 after undeleting the Contact
        System.assertEquals(2, accountAfterUndelete.Count_Contact__c, 'Count_Contact__c should be 2 after undeleting a contact');
    }

    @isTest
    static void testHandlerDirectCall() {
        // Call the handler method directly
        Set<Id> accountIds = new Set<Id>{testAccount.Id};
        ContactTriggerHandler.countConRelToAcc(accountIds);

        // Re-query the Account to verify Count_Contact__c value
        Account accountAfterDirectCall = [SELECT Id, Count_Contact__c FROM Account WHERE Id = :testAccount.Id];

        // Assert the Count_Contact__c should still be 2 since we haven't changed contacts directly
        System.assertEquals(2, accountAfterDirectCall.Count_Contact__c, 'Count_Contact__c should still be 2 after direct handler call');
    }
}