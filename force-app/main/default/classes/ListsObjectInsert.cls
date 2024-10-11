public with sharing class ListsObjectInsert {
    public static void sObjListAcc() {
    List<Account> accList=new List<Account>();
    Account acc1=new Account(Name='Acc1201',Active__c='Yes');
    accList.add(acc1);

    Account acc2=new Account();
    acc2.Name='Acc1202';
    acc2.Active__c='No';
    accList.add(acc2);
    
    insert accList;
    }

    public static void sObjListDemo() {
    List<Demo__c>dmList=new List<Demo__c>();
    Demo__c dm1=new Demo__c(Name='Demo3',Tax__c='Sjf839482');
    dmList.add(dm1);

    Demo__c dm2=new Demo__c(Name='Demo4',Tax__c='wdw094393');
    dmList.add(dm2);

    insert dmList;
    }
}

/*
Calling-
List<Account>accList=[SELECT Id,Name FROM Account WHERE Active__c = 'Yes'];
System.debug('Account List='+accList);

List<Demo__c>dmList=[SELECT Id,Name FROM Demo__c LIMIT 5];
System.debug('Demo List='+dmList);
*/