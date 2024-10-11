@isTest
public with sharing class QueueConClonTest {
    @testSetup
    static void setup(){
        List<Account>accList=new List<Account>();
        for(Integer i=1;i<=5;i++){
            Account acc=new Account();
            acc.Name='Queue'+i;
            acc.Industry='Engineering';
            accList.add(acc);
        }
        insert accList;
        Contact con=new Contact(LastName='QueueableApex');
        insert con;
    }
    @isTest
    public static void testContactClone(){
        Contact cont=[SELECT Id,LastName FROM Contact WHERE LastName='QueueableApex'];
        String industryValue='Engineering';
        Test.startTest();
        QueueContactClone conClone=new QueueContactClone(cont,industryValue);
        Id jobId=System.enqueueJob(conClone);
        Test.stopTest();
        System.assertEquals(5, [SELECT COUNT() FROM Contact WHERE AccountId IN (SELECT Id FROM Account WHERE Industry='Engineering')]);
    }
}