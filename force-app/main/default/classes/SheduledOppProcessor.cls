public with sharing class SheduledOppProcessor Implements Schedulable{
    public void execute(SchedulableContext ctx){
        List<Opportunity>oppList=[SELECT Id,LeadSource FROM Opportunity WHERE LeadSource =NULL LIMIT 200];
        for(Opportunity opp:oppList){
            opp.LeadSource='Web';
        }
        if(!oppList.isEmpty()){
            update oppList;
        }
    }
}