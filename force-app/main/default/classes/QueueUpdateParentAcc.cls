public class QueueUpdateParentAcc implements Queueable{
    private List<Account> accList;
    private Id parentAccId;
    public QueueUpdateParentAcc(List<Account> accRecords,Id accId) {
        this.accList=accRecords;
        this.parentAccId=accId;
    }
    public void execute(QueueableContext context){
        for(Account acc:accList){
            acc.ParentId=parentAccId;
        }
        update accList;
    }
}