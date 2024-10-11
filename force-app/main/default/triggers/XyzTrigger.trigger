trigger XyzTrigger on xyz__c (before insert,after insert) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            XyzCls.xyzTrigger(Trigger.new);
        }
    }else if(Trigger.isAfter){
        
    }
}