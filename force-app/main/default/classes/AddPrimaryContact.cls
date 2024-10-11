public with sharing class AddPrimaryContact Implements Queueable {
    private Contact primaryCon;
    private String billingState;
    public AddPrimaryContact(Contact con,String state) {
        this.primaryCon=con;
        this.billingState=state;
    }
    public void execute(QueueableContext context){
        List<Account>accList=[SELECT Id FROM Account WHERE BillingState=:billingState LIMIT 200];
        if(!accList.isEmpty()){
            List<Contact>conList=new List<Contact>();
            for(Account acc:accList){
                Contact newCon=primaryCon.clone(false, true, false);
                newCon.AccountId=acc.Id;
                conList.add(newCon);
            }
            if(!conList.isEmpty()){
                insert conList;
            }
        }
    }
}