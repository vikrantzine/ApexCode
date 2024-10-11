public with sharing class AccountTriggerHandler {
    public static void beforeInsert(List<Account>accList){
        for(Account acc:accList){
            acc.Description='Account Handler Triggered record Inserted';
        }
    }

    public static void populateRating(List<Account>accList){
        for(Account acc:accList){
            if(acc.Industry!=null && acc.Industry=='Media'){
                acc.Rating='Hot';
            }
        }
    }

    public static void createOpp(List<Account>accList){
        List<Opportunity>oppList=new List<Opportunity>();
        for(Account acc:accList){
            Opportunity opp=new Opportunity();
            opp.Name=acc.Name;
            opp.CloseDate=System.today();
            opp.StageName='Prospecting';
            opp.AccountId=acc.Id;
            oppList.add(opp);
        }
        if(!oppList.isEmpty()){
            insert oppList;
        }
    }

    public static void updatePhone(List<Account>accList,Map<Id,Account>accOldMap){
        for(Account acc:accList){
            if(acc.Phone!=accOldMap.get(acc.Id).Phone){
                acc.Description='Phone is Updated ! Old Value='+accOldMap.get(acc.Id).Phone+'New Value='+acc.Phone;
            }
        }
    }

    public static void populateRating1(List<Account>accList,Map<Id,Account>accOldMap){
        for(Account acc:accList){
            if((accOldMap==null && acc.Industry!=Null && acc.Industry=='Media')
             ||(acc.Industry!=accOldMap.get(acc.Id).Industry && acc.Industry=='Media')){
                acc.Rating='Hot';
             }
        }
    }
}