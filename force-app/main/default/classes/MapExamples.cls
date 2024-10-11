public with sharing class MapExamples {
    public static void mapMethod(){
        Map<Integer,String>colors=new Map<Integer,String>();
        colors.put(1,'Green');
        colors.put(2,'Blue');
        colors.put(3,'Red');
        colors.put(4,'Blue');

        //Adding key and values in Map
        System.debug('Map Contains='+colors);
        colors.put(2,'Yellow');
        System.debug('Map Contains='+colors);
        
        //Create one more Map-moreColors
        Map<Integer,String>moreColors=new Map<Integer,String>();
        moreColors.put(10,'Black');
        moreColors.put(20,'White');

        //Add one Map key and vbalues to Another Map
        colors.putAll(moreColors);
        System.debug('Map Contains='+colors);
        
        //sObject Map
        List<Account>accList=new List<Account>();
        Map<Id,Account>accMap=new Map<Id,Account>();

        //Accept 5 Id&name of Account Records
        accList=[SELECT Id,Name FROM Account LIMIT 5];

        //Add one List Values to Another Map
        accMap.putAll(accList);
        System.debug('Map Contains='+accMap);

        //Remove Key Value using key
        colors.remove(1);
        System.debug('Mao Contains='+colors);

        //Check Map size,eg-How many Values
        System.debug('Map Size='+colors.size());

        //Create one more Map-clonedMap
        Map<Integer,String>clonedMap=new Map<Integer,String>();
        clonedMap=colors.clone();
        System.debug('Cloned Map'+clonedMap);

        //Clear ConedMap,eg,empty
        clonedMap.Clear();
        System.debug('Cloned Map='+clonedMap);

        //Check Values Available in clonedMap or not
        clonedMap=colors.clone();
        System.debug('Map Contains Key 50='+clonedMap.ContainsKey(50));
        System.debug('Map Contains Key 10='+clonedMap.ContainsKey(10));

        //Check one Map equals Another Map
        System.debug('Map is Equals='+clonedMap.equals(colors));
        System.debug('Map is Equals='+clonedMap.equals(moreColors));

        //Show map values using key,From get() method
        System.debug('Get Map 10='+clonedMap.get(10));

        //Check Map is Empty or not
        System.debug('Map is Empty='+clonedMap.isEmpty());

        //Display Map Keys
        System.debug('Map Keys='+clonedMap.keySet());
    }
}