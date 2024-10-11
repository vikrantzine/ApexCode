//Module 11
//Assignment-5
//Question 1
@isTest
public with sharing class QueueableContactInsertTest {
    @TestSetup
    static void setup(){
        List<Account>accList=new List<Account>();
        for(Integer i=1;i<=5;i++){
            accList.add(new Account(Name='Test Acc'+i));
        }
        insert accList;
    }
    @isTest
    Public static void testQueableContactInsert(){
        List<Id>accIds=new List<Id>();
        for(Account acc:[SELECT Id FROM Account LIMIT 5]){
            accIds.add(acc.Id);
        }
        Test.startTest();
        System.enqueueJob(new QueueableContactInsert(accIds));
        Test.stopTest();
        List<Contact>conList=[SELECT Id,FirstName,LastName,AccountId FROM Contact];
        System.assertEquals(5, conList.size(), 'Number of Contacts should match the Number of Accounts');
        for(Contact con:conList){
            System.assert(con.AccountId!=NULL, 'Contact should be Linked to an Account');
            System.assert(con.FirstName=='Sample', 'Contact should have First Name"Sample"');
            System.assert(con.LastName.startsWith('Test Acc'), 'Contact should have the correct Last name');
        }
    }
}