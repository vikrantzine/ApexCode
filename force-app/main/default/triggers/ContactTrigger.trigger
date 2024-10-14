//Task of Mentor 2
trigger ContactTrigger on Contact (after insert, after update, after delete, after undelete) {
    if (Trigger.isInsert || Trigger.isUndelete) {
        if(Trigger.isAfter){
            //ContactTriggerHandler.totalContactCount(Trigger.new);
        }
    }
    if(Trigger.isDelete || Trigger.isUpdate){
        //ContactTriggerHandler.totalContactCount(Trigger.old);
    }
}