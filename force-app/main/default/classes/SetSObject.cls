public with sharing class SetSObject {
    public static void sObjectAccSet(){
        Set<Id>accIds=new Set<Id>();
        List<Account>accList=new List<Account>();
        accList=[SELECT Id,Name FROM Account LIMIT 5];
        for(Account acc:accList){
            accIds.add(acc.Id);
        }
        System.debug('Set Contains='+accIds);
    }
    public static void sObjectDemoSet(){
        Set<Id>dmIds=new Set<Id>();
        List<Demo__c>dmList=new List<Demo__c>();
        dmList=[SELECT Id FROM Demo__c LIMIT 5];
        for(Demo__c dem:dmList){
            dmIds.add(dem.Id);
        }
        System.debug('Set Contains='+dmIds);
    }
}