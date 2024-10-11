@isTest
public with sharing class QueueUpdateParentaccTest {
    @testSetup
    static void setup(){
        List<Account>accList=new List<Account>();
        accList.add(new Account(Name='Parent'));
        for(Integer i=1;i<=100;i++){
            accList.add(new Account(Name='Test Acc'+i));
        }
        insert accList;
    }
    @isTest
    private static void testQueueable(){
        Id parentId=[SELECT Id FROM Account WHERE Name='Parent'][0].id;
        List<Account>accList=[SELECT Id FROM Account WHERE Name LIKE 'Test Acc%'];
        QueueUpdateParentAcc updateJob=new QueueUpdateParentAcc(accList,parentId);
        Test.startTest();
        System.enqueueJob(updateJob);
        Test.stopTest();
        System.assertEquals(100, [SELECT COUNT() FROM Account Where parentId=:parentId]);
    }
}