//Module 11
//Assignment-4
//Question 2
public with sharing class UpdateAccountFieldBatch implements Database.Batchable<SObject>{
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Id,Ownership FROM Account WHERE Ownership !=\'Public\'');
    }
    public void execute(Database.BatchableContext bc,List<Account>scope){
        for(Account acc:scope){
            acc.Ownership='Private';
        }
        try{
            update scope;
        }catch(DmlException e){
            System.debug('Error Updating Accounts'+e.getMessage());
        }
    }
    public void finish(Database.BatchableContext bc){
        System.debug('Batch for Update Account Filed is Completed');
    }
}