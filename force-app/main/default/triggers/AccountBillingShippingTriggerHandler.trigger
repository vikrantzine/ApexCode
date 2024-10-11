trigger AccountBillingShippingTriggerHandler on Account (before insert) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            AccountTriggerBillingShipping.billingShipping(trigger.new);
        }
    }
}