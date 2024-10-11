public class CustomsObiectJobCandWithCompanyApp {
    public static void createJob(){
        Job__c jo=new Job__c();
        jo.Name_del__c='Om Sai';
        jo.Name='Om';
        jo.Expires_ON__c=System.Today()+2;
        jo.Manager__c='Administrative Manager';
        insert jo;
    }
    public static void createCand(){
        Candidate__c can=new Candidate__c();
        can.Name='Ram';
        can.Job__c='Administrative Manager';
        insert can;
    }
}