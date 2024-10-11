@isTest
public with sharing class MyDataGenerationTests {
    @TestSetup
    static void otherAccountData(){
        List<SObject>acc=Test.loadData(Account.SobjectType, 'otherAccountData');
    }
    @isTest
    static void testLoadOtherAccountsFromStaticResource(){
        List<Account>accList=[SELECT Id FROM Account];
        System.assert(accList.size()==15,'Expected 15 Accounts');
    }
}