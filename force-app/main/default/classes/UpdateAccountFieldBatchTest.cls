//Module 11
//Assignment-4
//Question 2
@isTest
public with sharing class UpdateAccountFieldBatchTest {
    @TestSetup
    static void setup(){
        List<Account>accList=new List<Account>();
        accList.add(new Account(Name='Test Account 1',Ownership='Public'));
        accList.add(new Account(Name='Test Account 2',Ownership='Private'));
        insert accList;
    }
    @isTest
    public static void testBatchExecution(){
        List<Account>accBefore=[SELECT Id,OwnerShip FROM Account];
        System.assertEquals('Public', accBefore[0].Ownership,'Field value should be Updated to "Public"');
        System.assertEquals('Private', accBefore[1].Ownership,'Field value should be Updated to "Private"');
        Test.startTest();
        UpdateAccountFieldBatch batch=new UpdateAccountFieldBatch();
        Database.executeBatch(batch);
        Test.stopTest();
        List<Account>accAfter=[SELECT Id,Ownership FROM Account];
        for(Account acc:accAfter){
            System.assertEquals('Public', accAfter[0].Ownership, 'Field value should be Updated to "Public"');
            System.assertEquals('Private', accAfter[1].Ownership, 'Field value should be Updated to "Private"');
        }
    }
}