//Assignment-2
public with sharing class JobTriggerHandler {
    private static Boolean isRecursive = false;

    // Handle after undelete scenario
    public static void updateAfterUndelete(List<Job__c> jobList){
        if (isRecursive) return;  // Prevent recursion
        isRecursive = true;

        List<Job__c> jobToUpdate = new List<Job__c>();
        for (Job__c jo : jobList) {
            Job__c updatedJob = new Job__c(Id = jo.Id);
            updatedJob.After_Undelete__c = 'Record was Undeleted...';
            jobToUpdate.add(updatedJob);
        }
        if (!jobToUpdate.isEmpty()) {
            update jobToUpdate;
        }
        isRecursive = false;  // Reset the static variable
    }
}