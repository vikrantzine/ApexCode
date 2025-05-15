public class OpportunityCount {
    public static void countOppAm(List<Opportunity> oppList, Map<Id,Opportunity> oldOpp){
        List<Opportunity>updOpp=new List<Opportunity>();
        Decimal cOp=0;
        for(Opportunity opp:[SELECT Id, CreatedDate, Amount FROM Opportunity WHERE CreatedDate = THIS_YEAR]){
            if(opp.Amount!=NULL){
                cOp+=opp.Amount;
            }
        }
        Decimal lOp=0;
        for(Opportunity opp:[SELECT Id, CreatedDate, Amount FROM Opportunity WHERE CreatedDate = LAST_YEAR]){
            if(opp.Amount!=NULL){
                lOp+=opp.Amount;
            }
        }
        for(Opportunity opp:oppList){
            if(oldOpp.containsKey(opp.Id) && opp.CloseDate != oldOpp.get(opp.Id).CloseDate){
                opp.This_Year_Amount__c=cOp;
                opp.Last_Year_Amount__c=lOp;
                updOpp.add(opp);
            }
        }
        if(!updOpp.isEmpty()){
            update updOpp;
        }
    }
}