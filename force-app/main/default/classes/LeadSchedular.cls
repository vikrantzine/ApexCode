public with sharing class LeadSchedular implements Schedulable{
    private Id oppId;
    public LeadSchedular(Id opportunityId) {
        this.oppId=opportunityId;
    }
    public void execute(SchedulableContext sc){
        Opportunity opp=[SELECT Id,Name,AccountId FROM Opportunity WHERE Id=:oppId];
        Account relatedAcc=[SELECT Id,Name FROM Account WHERE Id=:opp.AccountId LIMIT 1];
        Lead ld=new Lead(LastName=relatedAcc.Name,Company=relatedAcc.Name,Status='Open - Not Contacted');
        insert ld;
    }
}