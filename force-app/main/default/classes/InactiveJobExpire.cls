public with sharing class InactiveJobExpire implements Schedulable{
    public void execute(SchedulableContext sc){
        List<Job__c>jobList=[SELECT Id,Active__c FROM Job__c WHERE Expires_ON__c < TODAY AND Active__c != false];
        for(Job__c job:jobList){
            job.Active__c=false;
        }
        if(!jobList.isEmpty()){
            update jobList;
        }
    }
}