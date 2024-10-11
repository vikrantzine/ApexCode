public with sharing class OpportunityHandler {
    @future(callout=false)
    public static void sendEmailToCon(Id oppId){
        Opportunity opp=[SELECT Id,Name,StageName,ContactId,AccountId FROM Opportunity WHERE Id=:oppId];
        Contact relatedCon=[SELECT Id,Email,FirstName FROM Contact WHERE Id=:opp.ContactId LIMIT 1];
        if(relatedCon.Email != NULL){
            Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
            mail.setToAddresses(new String[] {relatedCon.Email});
            mail.setSubject('Opportunity is Close Won');
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
    }
    
    public static void scheduleLeadCreation(Id oppId){
        Datetime tomorrow = System.now().addDays(1);
        String cronExp = '0 0 ' + tomorrow.hour() + ' ' + tomorrow.day() + ' ' + tomorrow.month() + ' ? ' + tomorrow.year();
        System.schedule('Lead Creation'+oppId, cronExp, new LeadSchedular(oppId));
    }
}