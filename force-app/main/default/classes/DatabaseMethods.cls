public with sharing class DatabaseMethods {
    public static void databsaeClass(){
        List<Contact>conList=new List<Contact>{
            new Contact(FirstName='Joe',LastName='Smith',Department='Finance'),
            new Contact(FirstName='Kathy',LastName='Smith',Department='Technology'),
            new Contact(FirstName='Caroline',LastName='Roth',Department='Finance'),
            new Contact() 
            };        //Empty Records Required field error...
            Database.SaveResult[] srList=Database.insert(conList,false);
            //Iterate through each returned Result...
            for(Database.SaveResult sr : srList){
                if(sr.isSuccess()){
                    //Operation was Successful,so get the ID of the record that was processed...
                    System.debug('Successfully inserted Contact. Contact ID:'+sr.getId());
                }else{
                    //Operation failed,so get all errors...
                    for(Database.error err:sr.getErrors()){
                        System.debug('The following has occured...');
                        System.debug(err.getStatusCode()+':'+err.getFields());
                    }
                }
        }
    }
}