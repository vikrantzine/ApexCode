trigger AuthorTrigger on Author__c (before insert,before update,before delete) {
    if(Trigger.isBefore){
        if(Trigger.isInsert || Trigger.isUpdate){
            AuthorTriggerHandler.populateDesc(Trigger.New);
        }
        if(Trigger.isDelete){
            AuthorTriggerHandler.preventDeletion(Trigger.old);
        }
    }
}