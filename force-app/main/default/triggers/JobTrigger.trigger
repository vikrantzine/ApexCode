trigger JobTrigger on Job__c (before update,after update, before delete) {
    if (Trigger.isBefore) {
        if (Trigger.isDelete) {
            CandidateTriggerHandler.activeJobNotDelete(Trigger.old);    // Question 4
        }else if(Trigger.isUpdate){
            CandidateTriggerHandler.updateActivefieldOnPosChange(Trigger.old, Trigger.new);    // Question 6
        }
    } 
    if (Trigger.isAfter) {
        if (Trigger.isUpdate) {
            CandidateTriggerHandler.candHiredNoOfCand(Trigger.old, Trigger.new);    // Question 5
        }
    }
}