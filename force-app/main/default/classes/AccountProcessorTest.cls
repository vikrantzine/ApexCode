@isTest
public with sharing class AccountProcessorTest {
    @isTest
    public static void countContactTest(){
        Account acc=new Account(Name='Test');
        insert acc;
        List<Contact>conList=new List<Contact>();
        for(Integer i=1;i<=5;i++){
            conList.add(new Contact(FirstName='Test',LastName='Contact'+i,AccountId=acc.Id));
        }
        insert conList;
        Test.startTest();
        AccountProcessor.countContacts(new List<Id>{acc.Id});
        Test.stopTest();
        Account updatedAcc=[SELECT Number_Of_Contacts__c FROM Account WHERE Id=:acc.Id];
        System.assertEquals(5, updatedAcc.Number_Of_Contacts__c);
    }
}