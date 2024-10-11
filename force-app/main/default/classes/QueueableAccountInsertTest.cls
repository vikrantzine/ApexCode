//Module 11
//Assignment-5
//Question 3
@isTest
public with sharing class QueueableAccountInsertTest {
    @TestSetup
    static void setup(){
        List<Lead>leadList=new List<Lead>();
        for(Integer i=1;i<=3;i++){
            leadList.add(new Lead(FirstName='Test ld',LastName='Lead Name'+i,Company='Test Comp',LeadSource='Phone'));
        }
        insert leadList;
    }
    @isTest
    public static void testAccInsertLeadSourceUpdt(){
        List<Account>accList=new List<Account>();
        for(Integer i=1;i<=3;i++){
            accList.add(new Account(Name='Test Account'+i));
        }
        Test.startTest();
        System.enqueueJob(new QueueableAccountInsert(accList));
        Test.stopTest();
        List<Account>insertedAcc=[SELECT Id,Name FROM Account];
        System.assertEquals(3, insertedAcc.size(), 'There should be 3 inserted Account');
        List<Lead>updatedLead=[SELECT Id,LeadSource FROM Lead];
        for(Lead ld:updatedLead){
            System.assertEquals('Web', ld.LeadSource, 'LeadSouce should be Updated to Web');
        }
    }
}