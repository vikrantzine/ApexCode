//Assignment-2
@isTest
public with sharing class JobTriggerTestCls {
    @isTest
    public static void updateAfterUndelete(){
        Job__c job=new Job__c(Name='Test Job',Expires_ON__c=System.Today()+2,Number_of_positions__c=3);
        insert job;
        delete job;
        undelete job;
        Job__c updatedJob=[SELECT After_Undelete__c FROM Job__c WHERE Id=:job.Id];
        System.assertEquals('Record was Undeleted...', updatedJob.After_Undelete__c, 'The After_Undelete__c field is Updated...');
    }
}