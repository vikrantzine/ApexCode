public with sharing class LeadProcessor Implements Database.Batchable<SObject>, Database.stateful{
    public Database.QueryLocator Start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Id,LeadSource FROM Lead');
    }
    public void execute(Database.BatchableContext bc,List<Lead> leadList){
        if(!leadList.isEmpty()){
            for(Lead ld:leadList){
                ld.LeadSource='Dreamforce';
            }
            update leadList;
        }
    }
    public void finish(Database.BatchableContext bc){

    }
}