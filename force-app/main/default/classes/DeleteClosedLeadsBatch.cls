//Module 11
//Assignment-4
//Question 1
public with sharing class DeleteClosedLeadsBatch implements Database.Batchable<SObject>{
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Id FROM Lead WHERE Status= \'Closed - Not Converted\'');
    }
    public void execute(Database.BatchableContext bc,List<Lead>scope){
        try{
            delete scope;
        }catch(DmlException e){
            System.debug('Error Deleting Leads'+e.getMessage());
        }
    }
    public void finish(Database.BatchableContext bc){
        System.debug('Batch Job Delete Lead is Completed');
    }
}