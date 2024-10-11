public with sharing class ContactSearch {
    public static List<Contact>searchForContacts(String s1,String s2) {
        List<Contact>conList=[SELECT Id,Name FROM Contact WHERE LastName=:s1 AND MailingPostalCode=:s2];
        return conList;
    }
}