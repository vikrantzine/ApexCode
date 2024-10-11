public with sharing class SetExamples {
    public static void setMethod() {
        Set <Integer> intSet = new Set <Integer> ();
        List<Integer> intList =new List<Integer> ();

        Set<Integer>clonedSet=new Set<Integer>();
        intSet.add(10);
        intSet.add(20);
        intSet.add(30);
        intSet.add(20);
        System.debug('Set Contain='+intSet);

        intList.add(50);
        intList.add(60);
        intSet.addAll(intList);
        //Add List to Set
        System.debug('Set Contain='+intSet);

        clonedSet=intSet.clone();
        //Cloned the Set
        System.debug('Set Contains='+clonedSet);

        clonedSet.clear();
        //Clear all Cloned Set
        System.debug('Set Contains='+clonedSet);

        //Check Element is available
        System.debug('Element is Available when Available then true otherwise false='+intSet.contains(30));
        System.debug('Element is Available when Available then true otherwise false='+intSet.contains(100));

        //Check Set both is Eqaul/Same 
        System.debug('Equal='+intSet.equals(clonedSet));

        //Check set is Empty or Not
        System.debug('Empty='+intSet.isEmpty());

        //Remove perticaular Values on Set
        intSet.Remove(20);
        System.debug('Set Contains='+intSet);

        //Remove values of List on set
        //intSet.removeAll(intList);
        //System.debug('Set Contains'+intSet);

        intSet.retainAll(intList);
        System.debug('Set Contain='+intSet);

        //Check Size of Set
        System.debug('Size='+intSet.size());
    }
}