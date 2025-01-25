//Task 2
trigger ContactTrigger on Contact (after insert, after update, after delete, after undelete) {
    if (Trigger.isInsert || Trigger.isUndelete) {
        //ContactTriggerHandler.totalContactCount(Trigger.new);     //Task 2
    }
    if(Trigger.isDelete || Trigger.isUpdate){
        //ContactTriggerHandler.totalContactCount(Trigger.old);     //Task 2
    }
    if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete){
        ContactTriggerHandler.updateLasNameofUpdatedCon(Trigger.new);       //Task 4
    }
    if(Trigger.isDelete){
        ContactTriggerHandler.updateLasNameofUpdatedCon(Trigger.old);       //task 4
    }
}