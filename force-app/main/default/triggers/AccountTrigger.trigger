//Assignment-1
trigger AccountTrigger on Account (before insert, before update, before delete, after insert) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            AccountTriggerHandl.convertBillingToShipping(Trigger.New);  //Question 1
        }
        if(Trigger.isInsert || Trigger.isUpdate){
            AccountTriggerHandl.updateDescription(Trigger.New);  //Mentor Task 1
        }
        if(Trigger.isUpdate){
            AccountTriggerHandl.updateEngineeringToFinance(Trigger.New,Trigger.oldMap);  //Question 2
            AccountTriggerHandl.updateConPhoneOnAccChange(Trigger.New);  //Question 5
        }
        if(Trigger.isDelete){
            AccountTriggerHandl.preventAccDeletion(Trigger.oldMap);  //Question 3
            AccountTriggerHandl.sendMailOnAccDeletion(Trigger.oldMap);   //Question 6
        }
    }if(Trigger.isAfter){
        if(Trigger.isInsert){
            AccountTriggerHandl.createTaskForHighRevenue(Trigger.New);  //Question 4
        }
    }
}