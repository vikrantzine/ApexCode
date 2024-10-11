@isTest
public with sharing class LeadProcessorTest {
    @isTest
    public static void updateLeadTest(){
        List<Lead>leadList=new List<Lead>();
        for(Integer i=1;i<=200;i++){
            Lead ld=new Lead();
            ld.LastName='xyz'+i;
            ld.Company='abc'+i;
            leadList.add(ld);
        }
        Test.startTest();
        insert leadList;
        LeadProcessor ldProcess=new LeadProcessor();
        Database.executeBatch(ldProcess,200);
        Test.stopTest();
        List<Lead>updatedLead=[SELECT Id FROM Lead WHERE LeadSource='Dreamforce'];
        System.assertEquals(200, updatedLead.size());
    }
}