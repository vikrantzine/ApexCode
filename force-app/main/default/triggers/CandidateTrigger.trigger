trigger CandidateTrigger on Candidate__c (before insert, before update, after insert) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert || Trigger.isUpdate) {
            CandidateTriggerHandler.checkCandidateExpectedSal(Trigger.new);   //Question 1
            CandidateTriggerHandler.checkJobIsActive(Trigger.new);    //Question 2
            }
        }
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            CandidateTriggerHandler.applicationDate(Trigger.new);    //Question 3
        }
    }
}