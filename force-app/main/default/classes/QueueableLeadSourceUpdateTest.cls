//Module 11
//Assignment-5
//Question 2
@isTest
public with sharing class QueueableLeadSourceUpdateTest {
    @TestSetup
    static void setup(){
        List<Lead>leadList=new List<Lead>();
        for(Integer i=1;i<=5;i++){
            leadList.add(new Lead(FirstName='Test Lead',LastName='Lead '+i,Company='Test Company',LeadSource='Phone'));
        }
        insert leadList;
    }
    @isTest
    public static void testLeadSourceUpdate(){
        List<Id>leadIds=new List<Id>();
        for(Lead ld:[SELECT Id FROM Lead LIMIT 5]){
            leadIds.add(ld.Id);
        }
        Test.startTest();
        System.enqueueJob(new QueueableLeadSourceUpdate(leadIds));
        Test.stopTest();
        List<Lead>updatedLeads=[SELECT Id,LeadSource FROM Lead WHERE Id IN:leadIds];
        for(Lead ld:updatedLeads){
            System.assertEquals('Web', ld.LeadSource,'LeadSource Should be Updated to Web');
        }
    }
}