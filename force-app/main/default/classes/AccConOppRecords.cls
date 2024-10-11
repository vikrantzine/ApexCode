public class AccConOppRecords {
    public static Id insertAccount(String name,String rating,String active){
        Account acc = new Account();
        acc.Name = name;
        acc.Rating = rating;
        acc.Active__c = active;
        insert acc;
        return acc.Id;
    }
    public static void insertContact(){

        Id accId = insertAccount('Rushi','Hot','No');
        Contact con = new Contact(FirstName= 'Vaibhav',LastName= 'Pawar');
        con.accountId = accId;
        insert con;
    }
    public static void insertAccWithConAndOpp(String name,String rating,String active){
        Account acc = new Account();
        acc.Name = name;
        acc.Rating = rating;
        acc.Active__c = active;
        insert acc;

        Contact con = new Contact(FirstName= 'Vaibhav',LastName= 'Pawar');
        con.accountId = acc.Id;
        insert con;

        Opportunity opp=new Opportunity();
        opp.Name='Oppo1';
        opp.CloseDate=system.today();
        opp.StageName='Prospective';
        opp.AccountId=acc.Id;
        insert opp;
        
        Case cs=new Case();
        cs.Status=('New');
        cs.Origin='Phone';
        cs.AccountId=acc.Id;
        insert cs;
    }
}