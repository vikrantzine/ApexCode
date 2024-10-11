@isTest
public with sharing class DailyLeadProcessorTest {
    @TestSetup
    static void setup(){
        List<Lead>leadList=new List<Lead>();
        for(Integer i=1;i<=200;i++){
            leadList.add(new Lead(FirstName='Test',LastName='Lead'+i,Company='Test Company'));
        }
        insert leadList;
    }
    @isTest
    public static void testLeadToUpdate(){
        String cronExp = '0 0 0 * * ?';
        Test.startTest();
        String jobId=System.schedule('Test Daily Lead Processor', cronExp, new DailyLeadProcessor());
        Test.stopTest();
        List<Lead>updatedLead=[SELECT Id,LeadSource FROM Lead WHERE LeadSource='DreamForce'];
        System.assertEquals(200, updatedLead.size(), 'All least should have been updated.');
    }
}