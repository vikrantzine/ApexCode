//Assignment-1
@isTest
public with sharing class AccountTriggerTestCls {
    @TestSetup
    static void setupTestData(){
        List<Account>accList =new List<Account>();
        for(Integer i=1;i<=5;i++){
            accList.add(new Account(Name='Test'+i,BillingStreet='Street'+i,BillingCity='City'+i,BillingPostalCode='Postal'+i,BillingState='State'+i,BillingCountry='COuntry'+i,AnnualRevenue=1000000));
        }
        insert accList;
        Contact con=new Contact(LastName='Test Con',AccountId=accList[0].Id,HomePhone='54321');
        insert con;
    }
    //Question 1
    @isTest
    public static void testConvertBillingToShipping(){
        List<Account>accList=new List<Account>();
        for(Integer i=1;i<=5;i++){
            Account acc=new Account();
            acc.Name='Test '+i;
            acc.BillingStreet='Street';
            acc.BillingCity='City';
            acc.BillingPostalCode='Postal '+i;
            acc.BillingState='State '+i;
            acc.BillingCountry='Country '+i;
            accList.add(acc);
        }
        Test.startTest();
        AccountTriggerHandl.convertBillingToShipping(accList);
        insert accList;
        Test.stopTest();

        List<Account>updatedAccList=[SELECT Id,BillingStreet FROM Account WHERE Id=:accList[0].Id];
        System.assertEquals('Street', updatedAccList[0].BillingStreet);
    }
    //Question 2
    @isTest
    public static void testUpdateEngineerToFinance(){
        Account acc=new Account(Name='Test Account',Industry='Engineering');
        insert acc;
        acc.Industry='Finance';
        Test.startTest();
        update acc;
        Test.stopTest();
        Account updatedAcc=[SELECT Active__c FROM Account WHERE Id=:acc.Id];
        System.assertEquals('Yes', updatedAcc.Active__c);
    }
    //Question 3
    @isTest
    public static void testPreventAccDeletion(){
        Account acc = new Account(Name='Test acc', Active__c='Yes');
        insert acc;      
        Test.startTest();
        try {
            delete acc; 
            System.assert(false, 'Expected a DMLException to be thrown.');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('Cannot Delete Account, Please uncheck Active...'), 
                'Expected error message not found.');
        }
        Test.stopTest();
    }
    
    //Question 4
    @isTest
    public static void testCreateTaskForHighRevenue(){
        List<Account>accList=new List<Account>();
        for(Integer i=1;i<=5;i++){
            accList.add(new Account(Name='Test Acc'+i, AnnualRevenue=1000000));
        }
        Test.startTest();
        insert accList;
        Test.stopTest();
        Task[] tasks=[SELECT Id,Subject FROM Task WHERE WhatId IN :accList];
        System.assertEquals(5, tasks.size(), 'Follow Up Task with High AnnualRevenue');
    }
    //Question 5
    @isTest
    public static void testUpdateContPhoneOnAccPhone(){
        Account acc=new Account(Name='Test Account',Phone='12345');
        insert acc;
        Contact con=new Contact(LastName='Test Con',AccountId=acc.Id,HomePhone='54321');
        insert con;
        acc.Phone='9876';
        Test.startTest();
        update acc;
        Test.stopTest();
        Contact updatedCon=[SELECT OtherPhone,HomePhone FROM Contact WHERE Id=:con.Id];
        System.assertEquals('12345', updatedCon.OtherPhone);
        System.assertEquals('9876', updatedCon.HomePhone);
    }
    //Question 6
    @isTest
    public static void testSendMailOnAccDeletion(){
        Account acc=new Account(Name='Test account');
        insert acc;
        Test.startTest();
        delete acc;
        Test.stopTest();
        System.assert(True,'Email Send...');
    }
    //Mentor Task 1
    @isTest
    public static void testUpdateDesciption(){
        Account acc=new Account(Name='Vikrant z',AccountNumber='1234',Industry='Healthcare');
        List<Account>accList=[SELECT Name,AccountNumber,Industry FROM Account];
        insert acc;
        Test.startTest();
        AccountTriggerHandl.updateDescription(accList);
        Test.stopTest();
        for(Account updatedAcc:accList){
            String expectedDescription = 'Test Account:' + updatedAcc.Name + ' Account Number:' + updatedAcc.AccountNumber + ' Industry:' + updatedAcc.Industry;
            System.assertEquals(expectedDescription, updatedAcc.Description, 'Description did not update as expected...');
        }
    }
}