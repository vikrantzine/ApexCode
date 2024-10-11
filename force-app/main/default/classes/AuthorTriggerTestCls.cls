//Assignment-3
@isTest
public with sharing class AuthorTriggerTestCls {
    @isTest
    public static void testPopulateDesc(){
        Author__c author=new Author__c(Name='Test Author');
        insert author;
        Author__c insertedAuthor=[SELECT Description__c FROM Author__c WHERE Id=:author.Id];
        System.assertEquals(UserInfo.getFirstName(), insertedAuthor.Description__c, 'Description should be populate with the users First Name');
    }
    @isTest
    public static void testPreventDeletion(){
        Author__c author=new Author__c(Name='Test Author');
        insert author;
        Test.startTest();
        try{
            delete author;
            System.assert(false, 'Expected a DML for Deletion');
        }catch(DmlException e){
            System.assert(e.getMessage().contains('Deletion of Author records is not allowed...'));
        }
        Test.stopTest();
    }
}