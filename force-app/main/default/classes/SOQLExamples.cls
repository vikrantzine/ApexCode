public with sharing class SOQLExamples {
    public static void queryDemo(){
        //String rat='Cold';
        //Integer AR=10000;
        Set<Id>accIds=new Set<Id>();
        //List<Account>accList=[SELECT Id,Name,Industry,Type,Rating FROM Account WHERE Industry='Energy' AND Rating='Hot'];
        //List<Account>accList=[SELECT Id,Name,Industry,Type,Rating FROM Account WHERE Industry='Energy' OR Rating='Hot'];
        //List<Account>accList=[SELECT Id,Name,Industry,Type,Rating FROM Account WHERE Industry IN ('Electronics' , 'Energy')];
        //List<Account>accList=[SELECT Id,Name,Industry,Type,Rating FROM Account WHERE Rating='Hot' ORDER BY Name ASC];
        //List<Account>accList=[SELECT Id,Name,Industry,Type,Rating FROM Account WHERE Rating='Hot' ORDER BY Name DESC];
        //List<Account>accList=[SELECT Id,Name,Industry,Type,Rating FROM Account WHERE Rating='Hot' ORDER BY Name NULLS First];
        //List<Account>accList=[SELECT Id,Name,Industry,Type,Rating FROM Account WHERE Rating= :rat];
        //List<Account>accList=[SELECT Id,Name,Industry,Type,Rating,AnnualRevenue FROM Account WHERE AnnualRevenue >= :AR];
        List<Account>accList=[SELECT Id FROM Account LIMIT 10];

        for(Account acc:accList){
            accIds.add(acc.Id);
        }
        List<Account>accList1=[SELECT Id,Name,Industry,AnnualRevenue FROM Account WHERE Id IN:accIds];

        System.debug(accList1);
        System.debug([SELECT COUNT(Name) FROM Account]);
        System.debug([SELECT COUNT_DISTINCT(Industry) FROM Account]);
        System.debug([SELECT Min(AnnualRevenue) FROM Account]);
        System.debug([SELECT Max(AnnualRevenue) FROM Account]);
        System.debug([SELECT Avg(AnnualRevenue) FROM Account]);
        System.debug([SELECT SUM(AnnualRevenue) FROM Account]);
    }
    public static void aggFunctionDemo(){
        AggregateResult [] groupedResults=[SELECT Account.Name, Sum(Amount) FROM Opportunity GROUP BY Account.Name];
        System.debug(groupedResults);
        for(AggregateResult ar:groupedResults){
            System.debug('Account Id='+ar.get('Name'));
            System.debug('Sum of Amount='+ar.get('expr0'));
        }
    }
    //Using declare Amount field
    public static void aggFunctionDemo1(){
        AggregateResult [] groupedResults=[SELECT Account.Name, Sum(Amount) amt FROM Opportunity GROUP BY Account.Name];
        System.debug(groupedResults);
        for(AggregateResult ar:groupedResults){
            System.debug('Account Id='+ar.get('Name'));
            System.debug('Sum of Amount='+ar.get('amt'));
        }
    }
    //SOQL using For Loop
    public static void soqlUsingFor(){
        Set<Id>accIds=new Set<Id>();
        Map<Id,Account>accMap =new Map<Id,Account>();
        for(Account acc:[SELECT Id FROM Account WHERE AnnualRevenue>=10000 AND AnnualRevenue<=100000]){
            accIds.add(acc.Id);
        }
    }
    public static void parentToChildRelnOnStandardObj(){
        List<Account>accList=new List<Account>();
        accList=[SELECT Id,Name,(SELECT Id,FirstName,LastName FROM Contacts) FROM Account WHERE Rating='Hot'];
        for(Account acc:accList){
            System.debug('Account Name='+acc.Name);
            for(Contact con:acc.Contacts){
                System.debug(con.FirstName+' '+con.LastName);
            }
        }
    }
    public static void parentToChildRelnOnCustomObj(){
        List<Student__c>studList=[SELECT Id,Name,(SELECT Id,Name FROM xyzs__r) FROM Student__c];
        for(Student__c stud:studList){
            System.debug('Student Name='+stud.Name);
            for(xyz__c xy:stud.xyzs__r){
                System.debug(xy.Id+' '+xy.Name);
            }
        }
    }
    public static void childToParentRelnOnStandardObj(){
        List<Contact>conList=new List<Contact>();
        conList=[SELECT Id,FirstName,Account.Name FROM Contact LIMIT 5];
        for(Contact con:conList){
            System.debug('Contact Name='+con.FirstName);
                System.debug('Account Name='+con.Account.Name);
        }
    }
    public static void childToParentRelnOnCustomObj(){
        List<xyz__c>xyList=new List<xyz__c>();
        xyList=[SELECT Id,Name,Student__r.Name FROM xyz__c LIMIT 5];
        for(xyz__c xy:xyList){
            System.debug('XYZ Name='+xy.Name);
                System.debug('Student Name='+xy.Student__r.Name);
        }
    }
}