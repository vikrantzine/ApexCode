@isTest
public with sharing class ScheduledLeadSourceUpdateTest {
    @isTest
    public static void testScheduleLeadSourceUpdate(){
        List<Lead>leadList=new List<Lead>();
        for(Integer i=1;i<=5;i++){
            leadList.add(new Lead(FirstName='Test',LastName='Lead'+i,Company='Test Comp',LeadSource='Phone'));
        }
        insert leadList;
        Test.startTest();
        String leadSourceUpdate='Web';
        ScheduledLeadSourceUpdate job=new ScheduledLeadSourceUpdate(leadSourceUpdate);
        System.Schedule('Test Lead Source update Job','0 0 0 * * ?',job);
        Test.stopTest();
        List<Lead>updateList=[SELECT Id,LeadSource FROM Lead WHERE LeadSource=:leadSourceUpdate];
        System.assertEquals(5, updateList.size(),'List Job is Updated');
    }
}