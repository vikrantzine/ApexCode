public class ContactTriggerHnadlerForTestingDebugging {
    public static Contact conCreating(String name){
        Contact con;
        try{
            con=new Contact();
            con.LastName='';
            insert con;
            System.debug('Contact is:'+con);
        }catch(Exception e){
            System.debug('e=='+e.getCause() +e.getLineNumber() +e.getStackTraceString());
        }
        return con;
    }
}