@isTest
public with sharing class TestRestrictContactByName {

    @isTest
    public static void testTriggerForInsert() {
        // Create a contact with an invalid last name
        Contact con = new Contact(FirstName = 'John', LastName = 'INVALIDNAME');
        
        Test.startTest();
        try {
            // Attempt to insert the contact
            insert con;
            // Fail the test if no exception is thrown
            System.assert(false, 'Expected an exception for INVALIDNAME last name.');
        } catch (DmlException e) {
            // Verify that the exception message is correct
            System.assert(e.getMessage().contains('The Last Name "INVALIDNAME" is not allowed for DML'), e.getMessage());
        }
        Test.stopTest();
    }

    @isTest
    public static void testTriggerForUpdate() {
        // Insert a valid contact first
        Contact con = new Contact(FirstName = 'Jane', LastName = 'ValidName');
        insert con;
        
        // Now update the contact with an invalid last name
        con.LastName = 'INVALIDNAME';
        
        Test.startTest();
        try {
            // Attempt to update the contact
            update con;
            // Fail the test if no exception is thrown
            System.assert(false, 'Expected an exception for INVALIDNAME last name.');
        } catch (DmlException e) {
            // Verify that the exception message is correct
            System.assert(e.getMessage().contains('The Last Name "INVALIDNAME" is not allowed for DML'), e.getMessage());
        }
        Test.stopTest();
    }

    @isTest
    public static void testTriggerForValidName() {
        // Create and insert a contact with a valid last name
        Contact con = new Contact(FirstName = 'Alice', LastName = 'ValidName');
        
        Test.startTest();
        insert con;
        
        // Update the contact with another valid last name
        con.LastName = 'ValidName2';
        update con;
        Test.stopTest();

        // No exceptions should be thrown, so we assert true
        System.assert(true, 'No exception should be thrown for valid last names.');
    }
}