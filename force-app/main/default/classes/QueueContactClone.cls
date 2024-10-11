public with sharing class QueueContactClone implements Queueable{
    private Contact con;
    private string industryValue;
    public QueueContactClone(Contact con,String industryValue){
        this.con=con;
        this.industryValue=industryValue;
    }
    public void execute(QueueableContext context){
        List<Account>accList=[SELECT Id,Name FROM Account WHERE Industry=:industryValue LIMIT 200];
        List<Contact>conList=new List<Contact>();
        for(Account acc:accList){
            Contact c=con.clone(false,false,false,false);
            c.LastName = con.LastName; 
            c.AccountId=acc.Id;
            conList.add(c);
        }
        if(!conList.isEmpty()){
            insert conList;
        }
    }
}
/*
Invoke Method
Contact con=new Contact(LastName='Queueable Apex');
QueueContactClone conClone=new QueueContactClone(con,'Media');
Id jobId=System.enqueueJob(conClone);
*/