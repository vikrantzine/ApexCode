public with sharing class WireDemoLWC {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList(){
        List<Account> accountDetails=[SELECT Id,Name FROM Account];
        System.debug('Account Details='+accountDetails);
        return accountDetails;
    }
}