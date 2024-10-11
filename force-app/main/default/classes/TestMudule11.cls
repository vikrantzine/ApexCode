//Module 11
@isTest
public with sharing class TestMudule11 {
    //Assignment-3
    //Question 1
    @isTest
    public static void testCreateUserAndAccount(){
        String testUserName='TestUser1234vz@test.com';
        String testAccName='Test Account';
        Test.startTest();
        Module11.createUserAndAccount(testUserName, testAccName);
        Test.stopTest();
        Account acc=[SELECT Id,Name FROM Account WHERE Name=:testAccName LIMIT 1];
        User usr=[SELECT Id,Name FROM User WHERE UserName=:testUserName LIMIT 1];
        System.assertNotEquals(NULL, acc, 'Account Created');
        System.assertNotEquals(NULL, usr, 'User Created');
    }
    //Question 2
    @isTest
    public static void testFutureCreateUserAndAccount(){
        String testUserName='FutureTestUsefuewror@xyz.com';
        String testAccName='Future Account';
        Test.startTest();
        Module11.futureCreateUserAndAccount(testUserName, testAccName);
        Test.stopTest();
        Account acc=[SELECT Id,Name FROM Account WHERE Name=:testAccName LIMIT 1];
        User usr=[SELECT Id,UserName FROM User WHERE UserName=:testUserName LIMIT 1];
        System.assertNotEquals(NULL, acc, 'Account Created');
        System.assertNotEquals(NULL, usr, 'User Created');
    }
    //Question 3
    @isTest
    public static void testCountAccountContacts(){
        Account acc=new Account(Name='Account for Count Con');
        insert acc;
        for(Integer i=0;i<5;i++){
            Contact con=new Contact(FirstName='Test',LastName='Contact'+i,AccountId=acc.Id);
            insert con;
        }
        Test.startTest();
        Module11.countAccountContacts(acc.Id);
        Test.stopTest();
    }
    //Question 4,5
    @isTest
    public static void testCallFutureToFuture(){
        String testUserName='johlern53@lmn.com';
        String testAccountName='Future Test Acc';
        Test.startTest();
        Module11.callFutureFromFuture(testAccountName, testUserName);
        Test.stopTest();
        List<Account> accList=[SELECT Id,Name FROM Account WHERE Name=:testAccountName LIMIT 1];
        List<User> usrList=[SELECT Id,UserName FROM User WHERE USerName=:testUserName LIMIT 1];
        System.assertNotEquals(NULL, accList.size(), 'Account Created');
        System.assertNotEquals(NULL, usrList.size(), 'User Created');
        System.debug('Check Debug Log for Future method call Validation');
    }
}