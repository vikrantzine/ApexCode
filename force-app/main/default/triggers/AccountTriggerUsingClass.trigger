trigger AccountTriggerUsingClass on Account (before insert,after insert,before update) {
    if(Trigger.isInsert){
        if(Trigger.isBefore){
            AccountTriggerHandler.beforeInsert(Trigger.New);
            AccountTriggerHandler.populateRating1(Trigger.New,Null);
        }else if(Trigger.isAfter){
            AccountTriggerHandler.createOpp(Trigger.New);
        }
    }

    if(trigger.isUpdate){
        if(trigger.isBefore){
            //AccountTriggerHandler.updatePhone(Trigger.new,Trigger.oldMap);
            AccountTriggerHandler.populateRating1(Trigger.New,Trigger.oldMap);
        }
    }
}