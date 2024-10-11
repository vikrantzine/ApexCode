@isTest
public with sharing class AddPrimaryContactTest {
    @TestSetup
    static void setup(){
        List<Account>accList=new List<Account>();
        for(Integer i=1;i<=50;i++){
            accList.add(new Account(Name='Test Account NY'+i,BillingState='NY'));
            accList.add(new Account(Name='Test Account CA'+i,BillingState='CA'));
        }
        insert accList;
    }
    @isTest
    public static void testAddPrimaryCon(){
        Contact primaryCon=new Contact(FirstName='Primary',LastName='Contact',Email='vikrantzine@gmail.com');
        Test.startTest();
        AddPrimaryContact primaryCont=new AddPrimaryContact(primaryCon,'CA');
        System.enqueueJob(primaryCont);
        Test.stopTest();
        List<Contact>con=[SELECT Id,AccountId FROM Contact WHERE Email='vikrantzine@gmail.com'];
        System.assertEquals(50,con.size(),'Expected Contact record to be inserted for CA Accounts');
    }
}