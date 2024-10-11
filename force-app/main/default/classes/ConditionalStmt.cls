public class ConditionalStmt {
    public static void max(integer num1,integer num2){
        //integer num1=10,num2=30;
        if(num1>num2){
            System.debug('Num1 is Greater than Num2');
        }else{
            System.debug('Num2 is Greater than Num1');
        }
    }
    public static void checkEligibility(Integer age){
        if(age>=18){
            system.debug('You are Eligible for Vote...');
        }else{
            system.debug('You are Not Eligible for Vote...');
        }
    }
    public static void noEvenOdd(integer num){
        if(Math.mod(num,2)==0){
            system.debug('Number is Even...');
        }else{
            system.debug('Number is Odd...');
        }
    }
    public static void elseifLader(integer num){
        if(num>0){
            system.debug('Number is Positive...');
        }else if(num==0){
            system.debug('Number is 0...');
        }else{
            system.debug('Number is Negative...');
        }
    }
    public static void nestedIf(integer num){
        if(num>=0){
            if(num>0){
                system.debug('Number is Positive');
            }else{
                system.debug('Number is Zero');
            }
        }else{
            system.debug('Number is Negative');
        }
    }
    public static void usingAnd(){
        integer num1=10,num2=30;
        if(num1>50 && num2>100){
            System.debug('true');
        }else{
            System.debug('false');
        }
    }
    public static void usingOr(){
        Integer num1=50,num2=30;
        if(num1>60 || num2>20){
            system.debug('true');
        }else{
            system.debug('false');
        }
    }
    public static void checkListNull(){
        List <Account> accList = new List<Account> ();
        accList=[SELECT Id FROM Account LIMIT 5];
        if(!accList.isEmpty()){
            system.debug('List Conatains...'+accList);
        //if(accList.size()>0){
            //system.debug('List Contains...'+accList);
            //}
        }
    }
}