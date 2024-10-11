public with sharing class RandomContactFactory {
    public static List<Contact>generateRandomContacts(Integer noOfContacts,String commonLastName){
        List<Contact>conList=new List<Contact>();
        for(Integer i=0;i<noOfContacts;i++){
            Contact con=new Contact(FirstName='Test'+i,LastName=commonLastName);
            conList.add(con);
        }
        return conList;
    }
}