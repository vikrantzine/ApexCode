public class CreateUserWithNewEmail {
    public static void createUser(List<Contact> conList){
        List<User>uList=[SELECT Id,Email FROM User];
        List<User> uLL=new List<User>();
        for(Contact con:conList){
            for(User uL:uList){
                if(con.Email != uL.Email){
                User u =new User();
                u.UserName='demxyz';
                u.FirstName=con.FirstName;
                u.LastName=con.LastName;
                u.Email=con.Email;
                uLL.add(u);
            }
            }
        }
        if(!uLL.isEmpty()){
            insert uLL;
        }
    }
}