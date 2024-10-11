public with sharing class ExceptionHandlingTask {
    public static void createRecord(){
        try{
            Account acc=new Account();
            //acc.Name='AcHandling';
            insert acc;
        }catch (DmlException e){
            System.debug('Dml Exception='+e);
        }catch (Exception e){
            System.debug('Exception='+e);
        }

        try{
            Contact con=new Contact();
            con.LastName='AccConHandling';
            insert con;
        }catch(DmlException e){
            System.debug('Dml Exception='+e);
        }catch(Exception e){
            System.debug('Exception='+e);
        }
    }

    public static void handleDmlException(){
        try{
            Account acc=new Account(Name='Dml Handle');
            insert acc;
            Account acc1=new Account(Name='Dml Handle');
            insert acc1;
        }catch(DmlException e){
            System.debug('Dml Exception='+e);
        }
    }

    public static void handleListException(){
        try{
            List<Account>accList=new List<Account>();
            accList.add(new Account(Name='List Exception'));
            Account acc=accList[5];
        }catch(ListException e){
            System.debug('List Exception='+e);
        }
    }

    public static void nullPointerException(){
        try{
            Account acc=null;
            String Name=acc.Name;
        }catch(nullPointerException e){
            System.debug('Null Pointer Exception='+e);
        }
    }

    public static void handleQueryException(){
        try{
            List<Account>accList=[SELECT Id FROM Account WHERE Name='Not Available Records'];
            if (accList.isEmpty()) {
            throw new QueryException('No Accounts found with the name "NonExistentName".');
            }
            Account acc=accList[0];
        }catch(QueryException e){
            System.debug('Query Exception='+e);
        }
    }

    public static void customException(integer value){
        try{
            if(value==null || value<0){
                throw new MyCustomException('Invalid Value:'+value);
            }
            System.debug('Operation Successful with Value:'+value);
        }catch(MyCustomException e){
            System.debug('custom Exception:'+e);
        }
    }
    public class MyCustomException extends Exception{}
}