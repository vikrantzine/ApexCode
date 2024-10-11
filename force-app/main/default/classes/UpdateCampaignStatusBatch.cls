//Module 11
//Assignment-4
//Question 3
public with sharing class UpdateCampaignStatusBatch implements Database.Batchable<SObject>{
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Id,Status FROM Campaign WHERE Status != \'Completed\'');
    }
    public void execute(Database.BatchableContext bc,List<Campaign>scope){
        for(Campaign cam:scope){
            cam.Status='Completed';
        }
        try{
            update scope;
        }catch(DmlException e){
            System.debug('Error Updating Campaign Status:'+e.getMessage());
        }
    }
    public void finish(Database.BatchableContext bc){
        System.debug('Batch Job Update Campaign Status is Completed');
    }
}