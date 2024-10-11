//Module 11
//Assignment-5
//Question 2
public with sharing class QueueableLeadSourceUpdate implements Queueable{
    private List<Id> leadIds;
    public QueueableLeadSourceUpdate(List<Id> leadIds) {
        this.leadIds=leadIds;
    }
    public void execute(QueueableContext context){
        try{
            List<Lead>leadList=[SELECT Id,LeadSource FROM Lead WHERE Id IN : leadIds];
            for(Lead ld:leadList){
                ld.LeadSource='Web';
            }
            update leadList;
        }catch(DmlException e){
            System.debug('Error Updating leads:'+e.getMessage());
        }
    }
}