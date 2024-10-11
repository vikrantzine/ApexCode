//Module 11
//Assignment-4
//Question 3
@isTest
public with sharing class UpdateCampaignStatusBatchTest {
    @TestSetup
    static void setup(){
        List<Campaign>camList=new List<Campaign>();
        camList.add(new Campaign(Name='Campaign 1',Status='Planned'));
        camList.add(new Campaign(Name='Campaign 2',Status='In Progress'));
        camList.add(new Campaign(Name='Campaign 3',Status='Completed'));
        insert camList;
    }
    @isTest
    public static void testBatchExecution(){
        List<Campaign>camBefore=[SELECT Id,Status FROM Campaign];
        System.assertEquals('Planned', camBefore[0].status, 'Initial Status Should be "Planned"');
        System.assertEquals('In Progress', camBefore[1].status, 'Initial Status Should be "In Progress"');
        System.assertEquals('Completed', camBefore[2].status, 'Initial Status Should be "Completed"');
        Test.startTest();
        UpdateCampaignStatusBatch batch=new UpdateCampaignStatusBatch();
        Database.executeBatch(batch);
        Test.stopTest();
        List<Campaign>camAfter=[SELECT Id,Status FROM Campaign];
        System.assertEquals('Completed', camAfter[0].Status, 'Campaign 1 status should be Updated to "Completed"');
        System.assertEquals('Completed', camAfter[1].Status, 'Campaign 2 status should be Updated to "Completed"');
        System.assertEquals('Completed', camAfter[2].Status, 'Campaign 3 status should be Updated to "Completed"');
    }
}