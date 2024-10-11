public class ArithmeticOperatorsCalculation {
    public static void addition(){
        integer a=5,b=10,c;
        c=a+b;
        system.debug('Addition of '+a+' + '+b+' = '+c);
    }
    public static void substraction(){
        integer a=5,b=10,c;
        c=a-b;
        system.debug('Substraction of '+a+' - '+b+' = '+c);
    }
    public static void multiplication(){
        integer a=5,b=10,c;
        c=a*b;
        system.debug('Multiplication of '+a+' * '+b+' = '+c);
    }
    public void division(integer a,integer b){
        integer c=a/b;        
        system.debug('Division of '+a+' / '+b+' = '+c);
    }
}