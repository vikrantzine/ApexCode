trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    List<Task>taskList=new List<Task>();
    for(Opportunity opp:Trigger.new){
        if(opp.StageName=='Closed Won'){
            Task tsk=new Task();
            tsk.Subject='Follow Up Test Task';
            tsk.WhatId=opp.Id;
            tsk.OwnerId=opp.OwnerId;
            taskList.add(tsk);
        }
    }
    if(!taskList.isEmpty()){
        insert taskList;
    }
}