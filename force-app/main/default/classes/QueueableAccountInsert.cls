//Module 11
//Assignment-5
//Question 3
public with sharing class QueueableAccountInsert implements Queueable{
    private List<Account> accList;
    public QueueableAccountInsert(List<Account> accList) {
        this.accList=accList;
    }
    public void execute(QueueableContext context){
        try{
            insert accList;
            List<Id>leadIds=new List<Id>();
            for(Lead lead:[SELECT Id FROM Lead LIMIT 5]){
                leadIds.add(lead.Id);
            }
            if(!leadIds.isEmpty()){
                System.enqueueJob(new QueueableLeadSourceUpdate(leadIds));   
            }
        }catch(DmlException e){
            System.debug('Error Inserting Accounts'+e.getMessage());
        }
    }
}