@isTest
public with sharing class BatchUpdateConMailingAddressTest {
    @isTest
    public static void testAddressCopy(){
        List<Account>accList=new List<Account>();
        List<Contact>conList=new List<Contact>();
        for(Integer i=1;i<=5;i++){
            Account acc=new Account(Name='Account'+i,BillingCity='New York',BillingCountry='USA');
            accList.add(acc);
        }
        insert accList; 
        for(Account acc:accList){
            Contact con=new Contact();
            con.LastName='Test';
            con.AccountId=acc.Id;
            conList.add(con);
        }
        insert conList;
        Test.startTest();
        BatchUpdateContactMaillingAddress updateMailing=new BatchUpdateContactMaillingAddress();
        Id batchId=Database.executeBatch(updateMailing);
        Test.stopTest();
        Integer countedCon=[SELECT COUNT() FROM Contact WHERE MailingCity='New York'];
        System.assertEquals(5, countedCon);
    }
}