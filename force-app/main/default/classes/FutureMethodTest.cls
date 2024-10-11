@isTest
public with sharing class FutureMethodTest {
    @isTest
    public static void countContactTest(){
        List<Account>accList=new List<Account>();
        for(Integer i=1;i<=200;i++){
            accList.add(new Account(Name='Test'+i));
        }
        Test.startTest();
        insert accList;
        List<Contact>conList=new List<Contact>();
        List<Id>accIds=new List<Id>();
        for(Account acc:accList){
            Contact con=new Contact();
            con.FirstName='Test';
            con.LastName=acc.Name;
            con.AccountId=acc.Id;
            conList.add(con);
            accIds.add(acc.Id);
        }
        insert conList;
        FutureMethod.countContact(accIds);
        Test.stopTest();
        List<Account>accs=[SELECT Id,Count_Number_Of_contact__c FROM Account];
        System.assertEquals(1, accs[0].Count_Number_Of_Contact__c, 'Contacts are not Counted Successfully...');
    }
    @isTest
    public static void testCountCases(){
        List<Account>accList=new List<Account>();
        for(Integer i=1;i<=5;i++){
            Account acc=new Account(Name='Test'+i);
            accList.add(acc);
        }
        insert accList;
        List<Case>caseList=new List<Case>();
        List<Id>accIds=new List<Id>();
        for(Account acc:accList){
            accIds.add(acc.Id);
            for(Integer i=1;i<=3;i++){
                Case c=new Case();
                c.Status='New';
                c.Origin='Phone';
                c.AccountId=acc.Id;
                caseList.add(c);
            }
            for(Integer i=1;i<=3;i++){
                Case c=new Case();
                c.Status='New';
                c.Origin='Email';
                c.AccountId=acc.Id;
                caseList.add(c);
            }
            for(Integer i=1;i<=3;i++){
                Case c=new Case();
                c.Status='New';
                c.Origin='Web';
                c.AccountId=acc.Id;
                caseList.add(c);
            }
        }
        insert caseList;
        Test.startTest();
        FutureMethod.casesBasedOnOrigin(accIds);
        Test.stopTest();
        List<Account>updatedAcc=new List<Account>();
        updatedAcc=[SELECT Id,Case_Phone__c,Case_Email__c,Case_Web__c FROM Account WHERE Id IN:accIds];
        System.assertEquals(3, updatedAcc[0].Case_Phone__c);
        System.assertEquals(3, updatedAcc[0].case_Email__c);
        System.assertEquals(3, updatedAcc[0].case_Web__c);
    }
}