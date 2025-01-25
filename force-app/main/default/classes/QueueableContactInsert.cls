//Module 11
//Assignment-5
//Question 1
public with sharing class QueueableContactInsert implements Queueable{
    private List<Id> accIds;
    public QueueableContactInsert(List<Id> accId){
        this.accIds=accId;
    }
    public void execute(QueueableContext context){
        List<Contact>conList=new List<Contact>();
        List<Account>accList=[SELECT Id,Name FROM Account WHERE Id IN :accIds];
        for(Account acc:accList){
            Contact con=new Contact(FirstName='Sample',LastName=acc.Name+'Contact',AccountId=acc.Id);
            conList.add(con);
        }
        if(!conList.isEmpty()){
            try{
                insert conList;
            }catch(DmlException e){
                System.debug('Error inserting contacts'+e.getMessage());
            }
        }
    }
}