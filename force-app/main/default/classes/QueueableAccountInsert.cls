//Module 11
//Assignment-5
//Question 3
public with sharing class QueueableAccountInsert implements Queueable{
    private List<Account> accList;
    public QueueableAccountInsert(List<Account> accList) {
        this.accList=accList;
    }
    public void execute(QueueableContext context){
        if(accList!=NULL && !accList.isEmpty()){
            insert accList;
        }
        List<Id>ldIds=new List<Id>();
        List<Lead> ldList=[SELECT Id FROM Lead LIMIT 10];
        for(Lead ld:ldList){
            ldIds.add(ld.Id);
        }
        System.enqueueJob(new QueueableLeadSourceUpdate(ldIds));
    }
}