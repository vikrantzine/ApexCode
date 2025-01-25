public class BatchOppProcessor implements Database.Batchable<sObject>, Database.stateful{
    public Integer recordCount=0;
    public Database.QueryLocator Start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Id, LeadSource FROM Opportunity');
    }
    public void execute(Database.BatchableContext bc,List<Opportunity> oppList){
        if(!oppList.isEmpty()){
            for(Opportunity opp:oppList){
                opp.LeadSource='Web';
            }
            update oppList;
            recordCount=recordCount+oppList.size();
        }
    }
    public void finish(Database.BatchableContext bc){
        System.debug('Total Record Process:'+recordCount);
    }
}
/*
Invoke BatchOppProcessor
BatchOppProcessor oppProcess=new BatchOppProcessor();
Id batchId=Database.executeBatch(oppProcess);   //Id batchId=Database.executeBatch(oppProcess,10);
*/