trigger OpportunityTrigger on Opportunity (after update) {
    for(Opportunity opp:Trigger.new){
        if(opp.StageName=='Closed Won' && Trigger.oldMap.get(opp.Id).StageName !='Closed Won'){
            OpportunityHandler.sendEmailToCon(opp.Id);
        }
        if(opp.StageName=='Closed Lost' && Trigger.oldMap.get(opp.Id).StageName!='Closed Lost'){
            OpportunityHandler.scheduleLeadCreation(opp.Id);
        }
    }
}