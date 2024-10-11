public class XyzCls {
    public static void xyzTrigger(List <Xyz__c> xy){
        for(Xyz__c x:xy){
            x.Name='Om';
            x.Email1__c='v@c.dw';
            x.Address1__c='dw';
        }
    }
}