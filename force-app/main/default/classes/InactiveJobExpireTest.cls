@isTest
public with sharing class InactiveJobExpireTest {
    @TestSetup
    static void setup(){
        List<Job__c>jobList=new List <Job__c>();
        for(Integer i=1;i<=50;i++){
            jobList.add(new Job__c(Name='Expired Job'+i,Active__c=true,Expires_ON__c=Date.Today().addDays(-i -1)));
        }
        for(Integer i=1;i<=50;i++){
            jobList.add(new Job__c(Name='Active Job'+i,Active__c=true,Expires_ON__c=Date.Today().addDays(i +1)));
        }
        insert jobList;
    }
    @isTest
    public static void testJobExpire(){
        String cronExp='0 0 0 * * ?';
        Test.startTest();
        String jobId=System.schedule('Test Expired Job Inactivator', cronExp, new InactiveJobExpire());
        Test.stopTest();
        List<Job__c>expireJob=[SELECT Id,Active__c FROM Job__c WHERE Expires_ON__c < TODAY AND Active__c=false];
        System.assertEquals(50, expireJob.size(),'All Active Job Should be inactive');
        List<Job__c>activeJob=[SELECT Id,Active__c FROM Job__c WHERE Expires_ON__c >= TODAY AND Active__c=true];
        System.assertEquals(50, activeJob.size(), 'All Non Active job Should still be Active');
    }
}