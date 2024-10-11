public with sharing class ContactAndLeadSearch {
    public static List<List<sObject>>searchContactsAndLeads(String str) {
        List<List<sObject>>searchResult=[FIND :str IN Name Fields RETURNING Contact(Id,FirstName,LastName),Lead(Id,FirstName,LastName)];
        System.debug('Search Results: ' + searchResult);
        return searchResult;
    }
}