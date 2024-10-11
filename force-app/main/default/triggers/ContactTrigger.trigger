trigger ContactTrigger on Contact (after insert,after update,after delete) {
    if(Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete){
        ContactTriggerHandler.countConRelToAcc(Trigger.new, Trigger.old);    ///Task of Mentor 2
    
    }
}