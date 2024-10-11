public with sharing class DmlInsertRecords {
    public static void insertOneRec(){
        Account acc=new Account();
        acc.Name='Test DML 101';
        acc.Active__c='Yes';
        insert acc;
        System.debug('Account Id='+acc.Id);
    }
    public static void insertTwoRec(){
        Account acc=new Account();
        acc.Name='Test DML 102';
        acc.Active__c='No';
        insert acc;
        Account acc1=new Account();
        acc1.Name='Test DML 103';
        acc.Active__c='Yes';
        insert acc1;
    }
    public static void insertTwoRecUsingList(){
        List<Account>accList=new List<Account>();
        Account acc=new Account();
        acc.Name='Test DML 104';
        acc.Active__c='No';
        accList.add(acc);
        Account acc1=new Account();
        acc1.Name='Test DML 105';
        acc1.Active__c='Yes';
        accList.add(acc1);
        insert accList;
    }
    public static void insertRelatedRec(){
        List<Account>accList=new List<Account>();
        List<Contact>conList=new List<Contact>();
        Account acc=new Account();
        acc.Name='Test DML 106';
        acc.Active__c='Yes';
        accList.add(acc);
        Account acc1=new Account();
        acc1.Name='Test DML 107';
        acc1.Active__c='Yes';
        accList.add(acc1);
        insert accList;
        Contact con=new Contact();
        con.FirstName=acc.Name;
        con.LastName=acc.Name;
        con.AccountId=accList[0].Id;
        conList.add(con);
        Contact con1=new Contact();
        con1.FirstName=acc1.Name;
        con1.LastName=acc1.Name;
        con1.AccountId=accList[1].Id;
        conList.add(con1);
        insert conList;
    }
    public static void insertBulkRec(){
        List<Account>accList=new List<Account>();
        for(Integer i=1;i<=200;i++){
            Account acc=new Account();
            acc.Name='Test DML'+i;
            acc.Active__c='No';
            accList.add(acc);
        }
        insert accList;
    }
    public static void updateRecDML(){
        List<Account>accList=new List<Account>();
        accList=[SELECT Id,Name,Rating FROM Account WHERE Rating='Hot'];
        if(!accList.isEmpty()){
            for(Account acc:accList){
                acc.Industry='Media';
                acc.Active__c='Yes';
            }
            update accList;
        }
    }
    public static void upsertRec(){
        List<Account>accList=new List<Account>();
        accList=[SELECT Id,Name,Rating FROM Account WHERE Rating='Hot'];
        if(!accList.isEmpty()){
            for(Account acc:accList){
                acc.Industry='Energy';
                acc.Active__c='Yes';
            }
        }
        for(Integer i=1;i<=5;i++){
            Account acc=new Account();
            acc.Name='Test Upsert'+i;
            acc.Active__c='Yes';
            accList.add(acc);
        }
        if(!accList.isEmpty()){
            Upsert accList;
        }
    }
    public static void deleteRecDML(){
        List<Account>accList=new List<Account>();
        accList=[SELECT Id,Name,Rating FROM Account WHERE Name LIKE 'Test Upsert%'];
        if(!accList.isEmpty()){
            delete accList;
        }
    }
    public static void undeleteRec(){
        List<Account>accList=new List<Account>();
        accList=[SELECT Id,Name,Rating FROM Account WHERE Name LIKE 'Test Upsert%' ALL ROWS];
        if(!accList.isEmpty()){
            undelete accList;
        }
    }
}