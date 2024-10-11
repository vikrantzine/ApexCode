@isTest
    //Task of Mentor 2
private class ContactTriggerHandlerTest {
    @isTest
    static void testCountConRelToAcc() {
        // Create a new account
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        // Create contacts related to the account
        Contact con1 = new Contact(FirstName = 'John', LastName = 'Doe', AccountId = acc.Id);
        Contact con2 = new Contact(FirstName = 'Jane', LastName = 'Doe', AccountId = acc.Id);
        insert new List<Contact>{con1, con2};

        // Verify that the account contact count is updated
        acc = [SELECT Id, Count_Contact__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(2, acc.Count_Contact__c, 'The contact count should be 2 after inserting contacts.');

        // Update a contact
        con1.FirstName = 'Johnathan';
        update con1;

        // Verify that the account contact count remains unchanged
        acc = [SELECT Id, Count_Contact__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(2, acc.Count_Contact__c, 'The contact count should remain 2 after updating a contact.');

        // Delete a contact
        delete con2;

        // Verify that the account contact count is updated after deletion
        acc = [SELECT Id, Count_Contact__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(1, acc.Count_Contact__c, 'The contact count should be 1 after deleting a contact.');

        // Test for a contact with no related account
        Contact con3 = new Contact(FirstName = 'Alice', LastName = 'Smith');
        insert con3;

        // Verify that the account contact count remains unchanged
        acc = [SELECT Id, Count_Contact__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(1, acc.Count_Contact__c, 'The contact count should still be 1 after inserting a contact with no related account.');

        // Clean up
        delete new List<Contact>{con1, con3};
        delete acc; // Cleaning up the account as well
    }
}