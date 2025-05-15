trigger OppTrigger on Opportunity (after update) {
    if(Trigger.isAfter){
        if(Trigger.isUpdate){
            OpportunityCount.countOppAm(Trigger.new,Trigger.oldMap);
        }
        //if(Trigger.isDelete){
        //    OpportunityCount.countOppAm(Trigger.old,Trigger.oldMap);
        //}
    }
}