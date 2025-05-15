public class WelcomeController {
    public WelcomeController(){
        List<Account> accList = [SELECT Id, Name FROM Account];
        System.debug('My Account List:'+accList);
        System.debug('My Account List Size:'+accList.size());
    }
}