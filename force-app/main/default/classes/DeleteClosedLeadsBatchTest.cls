//Module 11
//Assignment-4
//Question 1
@isTest
public with sharing class DeleteClosedLeadsBatchTest {
    @TestSetup
    static void setup(){
        List<Lead>lead=new List<Lead>();
        lead.add(new lead(FirstName='John',LastName='Doe',Company='Test Company',Status='Closed - Not Converted'));
        lead.add(new lead(FirstName='Jane',LastName='Smith',Company='Test Company',Status='Open - Not Contacted'));
        lead.add(new lead(FirstName='Alice',LastName='Johnson',Company='Test Company',Status='Closed - Not Converted'));
        insert lead;
    }
    @isTest
    public static void testBatchExecution(){
        Integer totalLead=[SELECT COUNT() FROM Lead];
        System.assertEquals(3, totalLead, 'Initial status should insert 3 Lead');
        Test.startTest();
        DeleteClosedLeadsBatch batch=new DeleteClosedLeadsBatch();
        Database.executeBatch(batch);
        Test.stopTest();
        Integer remainLead=[SELECT COUNT() FROM Lead];
        System.assertEquals(1, remainLead, 'Only one Lead Remain After Batch Execution');
        Lead remainLeads=[SELECT Status FROM Lead LIMIT 1];
        System.assertNotEquals('Closed - Not Converted', remainLeads.Status, 'The Remaining Lead Should not Have Status "Closed - Not Converted"');
    }
}