public with sharing class AccountProcessor {
    @future
    public static void countContacts(List<Id> accIds){
        List<Account>accList=[SELECT Id,Number_Of_Contacts__c,(SELECT Id FROM Contacts)FROM Account WHERE Id IN:accIds];
        for(Account acc:accList){
            acc.Number_Of_Contacts__c=acc.Contacts.size();
        }
        if(!accList.isEmpty()){
            update accList;
        }
    }
}