public with sharing class ScheduledLeadSourceUpdate implements Schedulable{
    private String leadSource;
    public ScheduledLeadSourceUpdate(String leadSource) {
        this.leadSource=leadSource;
    }
    public void execute(SchedulableContext context){
        try{
            List<Lead>leadList= [SELECT Id, LeadSource FROM Lead WHERE LeadSource != :leadSource];
            for(Lead lead:leadList){
                lead.LeadSource=leadSource;
            }
            if(!leadList.isEmpty()){
                update leadList;
            }
        }catch(DmlException e){
            System.debug('Error Updating Lead records'+e.getMessage());
        }
    }
}