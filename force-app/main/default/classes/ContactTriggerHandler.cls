//Task of Mentor 2
public with sharing class ContactTriggerHandler {
    public static void totalContactCount(List<Contact> conList){
        List<Account> accList = new List<Account>();
        Set<Id> accIds = new Set<Id>();
        for(Contact con : conList){
            if(con.AccountId != null){
                accIds.add(con.AccountId);
            }
        }
        for (Account acc : [SELECT Id, (SELECT Id FROM Contacts) FROM Account WHERE Id IN :accIds]) {
        acc.Count_Number_Of_Contact__c = acc.Contacts.size();
        accList.add(acc);
        }
 
        if(!accList.isEmpty()){
            update accList;
        }
    }
}