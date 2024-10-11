public with sharing class ContactTriggerHandler {
    //Task of Mentor 2
    public static void countConRelToAcc(List<Contact>newCon,List<Contact>oldCon){
        Set <Id> accIds=new Set<Id>();
        if(newCon!=NULL){
            for(Contact con:newCon){
                if(con.AccountId!=NULL){
                    accIds.add(con.AccountId);
                }
            }
        }
        if(oldCon!=NULL){
            for(Contact con:oldCon){
                if(con.AccountId!=NULL){
                    accIds.add(con.AccountId);
                }
            }
        }
        if(!accIds.isEmpty()){
            List<Account>updatedAcc=[SELECT Id,(SELECT Id FROM Contacts)FROM Account WHERE Id IN:accIds];
            for(Account acc:updatedAcc){
                acc.Count_Contact__c=acc.Contacts.size();
            }
            update updatedAcc;
        }
    }
}