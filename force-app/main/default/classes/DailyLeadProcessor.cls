public with sharing class DailyLeadProcessor implements Schedulable{
    public void execute(SchedulableContext sc){
        List<Lead>leadList=[SELECT Id FROM Lead WHERE LeadSource=NULL LIMIT 200];
        for(Lead ld:leadList){
            ld.LeadSource='Dreamforce';
        }
        if(!leadList.isEmpty()){
            update leadList;
        }
    }
}