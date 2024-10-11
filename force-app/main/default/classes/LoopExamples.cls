public class LoopExamples {
    public static void evenNos(integer n){
        for(integer i=1;i<=n;i++){
            if(Math.mod(i,2)==0){
                system.debug('Even Nos='+i);
            }
        }
    }
    public static void oddNos(integer n){
        for(integer i=1;i<=n;i++){
            if(Math.mod(i,2)!=0){
                system.debug('Odd Nos='+i);
            }
        }
    }
    public static void sumOfNaturalNos(Integer n){
        integer i;
        integer sum=0;
        for(i=1;i<=n;i++){
            sum=sum+i;
        }
        system.debug('Sum='+sum);
    }
    public static void tableWithWhile(Integer n){
    Integer i=1;
    while(i<=10)
        System.debug(n+'*'+i+'='+n*i);
        i++;
    }
    public static void forLoopListSetMap(){
        List<Account>accList=new List<Account>();
        Set<Id>accIds=new Set<Id>();
        Map<Id,Account>accMap=new Map<Id,Account>();
        accList=[SELECT Id,Name FROM Account LIMIT 5];

        //Iteration on Account List to Display Data and Create Set and Map
        System.debug('Display Data through List');
        if(accList.size()>0){
            for(Account acc:accList){
                System.debug(acc.Id+'-'+acc.Name);
                accIds.add(acc.Id);    //Set is having Data
                accMap.put(acc.Id,acc);     //Map is having Data
            }
        }

        //Display accIds through Set
        System.debug('Display Data through Set');
        if(!accIds.isEmpty()){
            for(Id accId:accIds){
                System.debug(accId);
            }
        }

        //Iterate Map on based Keys
        System.debug('Display Data through Map Keys');
        if(!accMap.isEmpty()){
            for(Id accId:accMap.keySet()){
                System.debug(accId);
            }
        }

        //Iterate Map on based Values
        System.debug('Display Data through Map Values');
        if(!accMap.isEmpty()){
            for(Account acc:accMap.values()){
                System.debug(acc);
            }
        }
    }
}