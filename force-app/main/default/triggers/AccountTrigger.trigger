//Assignment-1
trigger AccountTrigger on Account (before insert, before update, before delete, after insert, after update) {
    if(Trigger.isBefore && Trigger.isUpdate||Trigger.isInsert){
        //AccountTriggerHandl.countCon(Trigger.new);      //Task 2 Try
    }
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            AccountTriggerHandl.insertAccRelCon(Trigger.new);       //Task 5
        }
        if(Trigger.isUpdate){
            AccountTriggerHandl.updateRelConName(Trigger.new, Trigger.oldMap, Trigger.newMap);      //Task 6
        }
    }
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            AccountTriggerHandl.convertBillingToShipping(Trigger.New);  //Question 1
        }
        if(Trigger.isInsert || Trigger.isUpdate){
            AccountTriggerHandl.updateDescription(Trigger.New);  //Mentor Task 1
            //AccountTriggerHandl.updatePhoneAndRelatedContact(Trigger.new, Trigger.oldMap);    //Task 3
        }
        if(Trigger.isUpdate){
            AccountTriggerHandl.updateEngineeringToFinance(Trigger.New,Trigger.oldMap);  //Question 2
            //AccountTriggerHandl.updateConPhoneOnAccChange(Trigger.New,Trigger.oldMap);  //Question 5
        }
        if(Trigger.isDelete){
            AccountTriggerHandl.preventAccDeletion(Trigger.old);  //Question 3
            AccountTriggerHandl.sendMailOnAccDeletion(Trigger.Old);   //Question 6
        }
    }if(Trigger.isAfter){
        if(Trigger.isInsert || Trigger.isUpdate){
            AccountTriggerHandl.createTaskForHighRevenue(Trigger.New);  //Question 4
        }
    }
}