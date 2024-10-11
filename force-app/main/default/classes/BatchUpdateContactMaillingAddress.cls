public with sharing class BatchUpdateContactMaillingAddress Implements Database.Batchable<SObject>,Database.stateful {
    public Integer recoredCount=0;
    public Database.QueryLocator start (Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Id,BillingStreet,BillingCity,BillingState,BillingPostalCode,'+'(SELECT Id,MailingStreet,MailingCity,MailingPostalCode,MailingState FROM Contacts)'+'FROM Account WHERE BillingCountry=\'USA\'');
    }
    public void execute(Database.BatchableContext bc,List<Account>accList){
        List<Contact>conList=new List<Contact>();
        for(Account acc:accList){
            for(Contact con:acc.Contacts){
                con.MailingStreet=acc.BillingStreet;
                con.MailingCity=acc.BillingCity;
                con.MailingState=acc.BillingState;
                con.MailingPostalCode=acc.BillingPostalCode;
                conList.add(con);
                recoredCount++;
            }
        }
        update conList;
    }
    public void finish(Database.BatchableContext bc){
        System.debug('Record Count='+recoredCount);
    }
}
/*
Invoke BatchUpdateContactMaillingAddress Method
BatchUpdateContactMaillingAddress updateMailing=new BatchUpdateContactMaillingAddress();
Id batchId=Database.executeBatch(updateMailing);
*/