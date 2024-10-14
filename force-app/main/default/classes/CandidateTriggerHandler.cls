//Assignment-4
public with sharing class CandidateTriggerHandler {
    //Question 1
    public static void checkCandidateExpectedSal(List<Candidate__c>candList){
        for(Candidate__c can:candList){
            if(can.Expected_Salary__c==NULL){
                can.Expected_Salary__c.addError('Candidate Excpected Salary is Missing...');
            }
        }
    }
    //Question 2
    public static void checkJobIsActive(List<Candidate__c>canList){
        set<Id>jobIds=new set<Id>();
        for(Candidate__c can:canList){
            if(can.Job__c!=NULL){
                jobIds.add(can.Job__c);
            }
        }
        Map<Id,Job__c>jobs=new Map<Id,Job__c>([SELECT Id,Active__c FROM Job__c WHERE Id IN:jobIds]);
        for(Candidate__c can:canList){
            Job__c job=jobs.get(can.Job__c);
            if(job!=NULL && !job.Active__c){
                can.addError('This job is not active you cannot apply this job...');
            }
        }
    }
    //Question 3
    public static void applicationDate(List<Candidate__c> canList){
        List<Candidate__c> candidatesToUpdate = new List<Candidate__c>();
        for(Candidate__c can: canList){
            if(can.Application_Date__c == null || can.Application_Date__c != null){
                Candidate__c updatedCandidate = new Candidate__c(Id = can.Id, Application_Date__c = can.CreatedDate.date());
                candidatesToUpdate.add(updatedCandidate);
            }
        }
        if(!candidatesToUpdate.isEmpty()){
            update candidatesToUpdate;
        }
    }
    //Question 4
    public static void activeJobNotDelete(List<Job__c>jobList){
        for(Job__c job:jobList){
            if(job.Active__c==true){
                job.addError('This Job is Active cannot be Deleted...');
            }
        }
    }
    //Question 5
    public static void candHiredNoOfCand(List<Job__c> oldJobList, List<Job__c> newJobList) {
        if (oldJobList == null || newJobList == null) return;
    
        List<Job__c> jobToDeactivate = new List<Job__c>();
        for (Integer i = 0; i < newJobList.size(); i++) {
            if (i >= oldJobList.size()) break;
    
            Job__c oldJob = oldJobList[i];
            Job__c newJob = newJobList[i];
    
            if (oldJob.Hired_Applicants__c != newJob.Hired_Applicants__c &&
                newJob.Hired_Applicants__c >= newJob.Number_of_positions__c) {
                
                jobToDeactivate.add(new Job__c(Id = newJob.Id, Active__c = false));
                sendJobCompletionEmail(newJob);
            }
        }
        if (!jobToDeactivate.isEmpty()) update jobToDeactivate;
    }
    
    public static void sendJobCompletionEmail(Job__c job) {
        if (job == null) return;
    
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new String[]{'vikrantzine@gmail.com'});
        email.setSubject('All required Candidates have been Hired for this Job: ' + job.LastModifiedDate);
        email.setPlainTextBody('Dear Manager,\n\nAll required candidates have been successfully hired for the job: ' 
                               + job.Name + '.\n\nJob ID: ' + job.Id 
                               + '\nNumber of Positions: ' + job.Number_of_positions__c 
                               + '\nHired Applicants: ' + job.Hired_Applicants__c 
                               + '\n\nThank you,\nYour Company Name');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
    }
    //Question 6
    public static void updateActivefieldOnPosChange(List<Job__c>oldJobList,List<Job__c>newJobList){
        List<Job__c>jobToUpdate=new List<Job__c>();
        for(Integer i=0;i<newJobList.size();i++){
            Job__c oldJob=oldJobList[i];
            Job__c newJob=newJobList[i];
            if(oldJob.Number_of_positions__c != newJob.Number_of_positions__c && newJob.Number_of_positions__c > newJob.Hired_Applicants__c && !newJob.Active__c){
                newJob.Active__c=true;
            }
        }
    }
}