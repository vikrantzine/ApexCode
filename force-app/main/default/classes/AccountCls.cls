public class AccountCls {
    public static void updOppSts(List<Account> accList){
        Set<Id>accIds=new Set<Id>();
        List<Opportunity> updOpp=new List<Opportunity>();
        for(Account acc:accList){
            if(!accList.isEmpty()){
                accIds.add(acc.Id);
            }
        }
        List<Opportunity> oppList=[SELECT Id, Name, DeliveryInstallationStatus__c, Account.Rating FROM Opportunity WHERE AccountId IN:accIds];
        for(Opportunity opp:oppList){
            if(opp.Account.Rating=='Hot'){
                opp.DeliveryInstallationStatus__c='Completed';
                updOpp.add(opp);
            }
            else if(opp.Account.Rating=='Cold' || opp.Account.Rating=='Warm'){
                opp.DeliveryInstallationStatus__c='In progress';
                updOpp.add(opp);
            }else{
                opp.DeliveryInstallationStatus__c='Yet to Begin';
                updOpp.add(opp);
            }
        }
        if(!updOpp.isEmpty()){
            update updOpp;
        }
    }
    public static void checkUserIsSystemAdminBeforeDel(List<Account> accList){
        Profile allowProf = [SELECT Id, Name FROM Profile WHERE Name='System Administrator'];
        if(UserInfo.getProfileId() != allowProf.Id){
            for(Account acc:accList){
                acc.addError('Only System Admin can Delete Account');
            }
        }
    }
}