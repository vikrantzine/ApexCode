public with sharing class MapSObject {
    public static void sObjAccWithoutLoop(){
        List<Account>accList=new List<Account>();
        accList=[SELECT Id,Name FROM Account LIMIT 5];
        Map<Id,Account>accMap=new Map<Id,Account>(accList);
        System.debug('Map with Keys and Values of Map='+accMap);
        System.debug('All Keys of Maps='+accMap.keySet());
        System.debug('All Values of Maps='+accMap.values());
    }

    public static void sObjectAccWithWhile(){
        List<Account>accList=[SELECT Id,Name FROM Account LIMIT 5];
        Map<Id,Account>accMap=new Map<Id,Account>(accList);
        Integer i=0;
        while(i<accList.size()){
            Account acc=accList[i];
            accMap.put(acc.id,acc);
            i++;
        }
        System.debug('Map with Key and Values='+accMap);
        System.debug('All Keys of Map='+accMap.keySet());
        System.debug('All Values of Map='+accMap.values());
    }

    public static void sObjDemoWithoutLoop(){
        List<Demo__c>dmList=new List<Demo__c>();
        dmList=[SELECT Id,Name FROM Demo__c LIMIT 5];
        Map<Id,Demo__c>dmMap=new Map<Id,Demo__c>(dmList);
        System.debug('Map with Keys and Values of Map='+dmMap);
        System.debug('All Keys of Maps='+dmMap.keySet());
        System.debug('All Values of Maps='+dmMap.values());
    }

    public static void sObjectDemoWithWhile(){
        List<Demo__c>dmList=[SELECT Id,Name FROM Demo__c LIMIT 5];
        Map<Id,Demo__c>dmMap=new Map<Id,Demo__c>(dmList);
        Integer i=0;
        while(i<dmList.size()){
            Demo__c dm=dmList[i];
            dmMap.put(dm.id,dm);
            i++;
        }
        System.debug('Map with Key and Values='+dmMap);
        System.debug('All Keys of Map='+dmMap.keySet());
        System.debug('All Values of Map='+dmMap.values());
    }
}