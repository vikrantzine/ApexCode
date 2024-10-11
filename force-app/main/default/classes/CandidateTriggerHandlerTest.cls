//Assignment-4
@isTest
public with sharing class CandidateTriggerHandlerTest {
    @TestSetup
    static void setupTestData(){
        List<Job__c>jobList=new List<Job__c>();
        jobList.add(new Job__c(Name='Job 1',Active__c=true,Number_of_positions__c=10,Expires_ON__c = Date.today()));
        jobList.add(new Job__c(Name='Job 2',Active__c=true,Number_of_positions__c=5,Expires_ON__c = Date.today()));
        insert jobList;
        List<Candidate__c>canList=new List<Candidate__c>();
        canList.add(new Candidate__c(First_Name__c='Test',Last_Name__c='Data',Expected_Salary__c=5000,Email__c='ABC@GF.COM', Job__c=jobList[1].Id));
        insert canList;
    }
    //Question 1
    @isTest
    public static void testCheckCandidatExpectedSal(){
        List<Candidate__c>canList=[SELECT Id,Expected_Salary__c FROM Candidate__c];
        Test.startTest();
        CandidateTriggerHandler.checkCandidateExpectedSal(canList);
        Test.stopTest();
        for(Candidate__c can:canList){
            if(can.Expected_Salary__c!=NULL){
                System.assertEquals(5000, can.Expected_Salary__c, 'Expected Salary Error...');
            }
        }
    }
    //Question 2
    @isTest
    public static void testCheckJobIsActive(){
        List<Candidate__c>canList=[SELECT Id,Job__c FROM Candidate__C];
        Test.startTest();
        CandidateTriggerHandler.checkJobIsActive(canList);
        Test.stopTest();
        for(Candidate__c can:canList){
            Job__c job=[SELECT Id,Active__c FROM Job__c WHERE Id=:can.Job__c];
            if(!job.Active__c){
                System.assertEquals(1, can.getErrors().size(), 'Job not active Error will Present...');
            }
        }
    }
    //Question 3
    @isTest
    public static void testApplicationDate(){
        List<Candidate__c>canList=[SELECT Id,Application_Date__c FROM Candidate__c];
        Test.startTest();
        CandidateTriggerHandler.ApplicationDate(canList);
        Test.stopTest();
        for(Candidate__c can:canList){
            System.assertEquals(System.today(), can.Application_Date__c, 'Application Date should be todays Date...');
        }
    }
    //Question 4
    @isTest
    public static void testActiveJobNotDelete(){
        List<Job__c>job=[SELECT Id,Active__c FROM Job__c WHERE Active__c=true];
        Test.startTest();
        try{
            delete job;
            System.assert(false, 'Exception should have been thrown for Active job deletion...');
        }catch(DmlException e){
            System.assert(true, 'Exception thrown as expected...');
        }
        Test.stopTest();
    }
    //Question 5
    @isTest
    public static void testCandidateHiredNoOfCand(){
        List<Job__c>job=[SELECT Id,Hired_Applicants__c,Number_of_positions__c FROM Job__c];
        job[0].Number_Of_Positions__c=job[0].Hired_Applicants__c-1;
        Test.startTest();
        update job;
        Test.stopTest();
    }
    //Question 6
    @isTest
    public static void testUpdateActiveFieldOnPosChange(){
        List<Job__c>job=[SELECT Id,Active__c,Number_Of_Positions__c,Hired_Applicants__c FROM Job__c];
        job[0].Number_Of_Positions__c=job[0].Hired_Applicants__c-1;
        Test.startTest();
        update job;
        Test.stopTest();
        Job__c updatedJob=[SELECT Active__c FROM Job__c WHERE Id=:job[0].Id];
        System.assert(updatedJob.Active__c, 'Job Should be Activated...');
    }
}