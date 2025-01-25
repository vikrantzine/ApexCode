public with sharing class AccountBulkRecord {
    public static void accBulkRec(){
        List<Account>accList=new List<Account>();
        
        for(Integer i=0;i<10000;i++){
            Account acc=new Account();
            acc.Name='Vikrant'+i;
            accList.add(acc);
        }
        if(!accList.isEmpty()){
            insert accList;
        }
    }
}