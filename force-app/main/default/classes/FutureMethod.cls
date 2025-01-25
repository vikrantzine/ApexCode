public with sharing class FutureMethod {
    @future
    public static void countContact(List<Id> accIds){
        List<Account>accList=[SELECT Id,Count_Number_Of_Contact__c,(SELECT Id FROM Contacts)FROM Account WHERE Id IN:accIds];
        for(Account acc:accList){
            acc.Count_Number_Of_Contact__c=acc.Contacts.size();
        }
        if(!accList.isEmpty()){
            update accList;
        }
    }
    @future
    public static void casesBasedOnOrigin(List<Id> accIds){
        List<Account>accList=[SELECT Id,Case_Email__c,Case_Phone__c,Case_Web__c,(SELECT Id,Origin FROM Cases)FROM Account WHERE Id IN:accIds];
        for(Account acc:accList){
            Integer Email=0,Phone=0,Web=0;
            for(Case ca:acc.Cases){
                if(ca.Origin=='Phone'){
                    Phone++;
                }else if(ca.Origin=='Email'){
                    Email++;
                }else if(ca.Origin=='Web'){
                    Web++;
                }
            }
            acc.Case_Phone__c=Phone;
            acc.Case_Email__c=Email;
            acc.Case_Web__c=web;
        }
        if(!accList.isEmpty()){
            update accList;
        }
    }
}

/*
Invoke countContact Method
List<Account>accList=[SELECT Id FROM Account LIMIT 10];
List<Id>accIds=new List<Id>();
for(Account acc:accList){
    accIds.add(acc.Id);
}
FutureMethod.countContact(accIds);

Invoke casesBasedOnOrigin Method
List<Account>accList=[SELECT Id FROM Account];
List<Id>accIds=new List<Id>();
for(Account acc:accList){
    accIds.add(acc.Id);
}
FutureMethod.casesBasedOnOrigin(accIds);
*/