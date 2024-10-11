public class SimpleInterest {
    public static void calc(){
        Decimal principle=5000,rate=10,tim=3;
        Decimal si=(principle*rate*tim)/100;
        system.debug('Simple Interest='+si);
    }
}