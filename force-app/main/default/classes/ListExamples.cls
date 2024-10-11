public with sharing class ListExamples {
    public static void listMethod() {
    List <String> colors = new List <String> ();
    colors.add('Red');
    colors.add('Green');
    colors.add('Blue');
    colors.add('Yellow');
    System.debug('Colors List Contains='+colors);

    colors.add(1,'Black');
    System.debug('Colors List Contains='+colors);

    List<String>colorsList2=new List<String>();
    colorsList2.add('White');
    colorsList2.add('Purple');
    colors.addAll(colorsList2);
    System.debug('Colors List Contains='+colors);

    System.debug('Colors List 2 Contains='+colorsList2);
    colorsList2.clear();
    System.debug('Colors List 2 Contains='+colorsList2);

    List<String>clonedList=new List<String>();
    clonedList=colors.clone();
    System.debug('COlned List Contains='+clonedList);
    }

    public static List<String>returnDemo(){
    List<String>colors=new List<String>{'Red','Yellow','Green'};
    return colors;
    }
    public static void listMethod1(){
    List <String>returnedValues=new List<String>();
    returnedValues=returnDemo();
    System.debug('Returned Value List='+returnedValues);
    
    List<String>colors=new List<String>();
    colors.add('Red');
    colors.add('Yellow');
    colors.add('Green');
    colors.add('Blue');
    colors.add('Yellow');
    System.debug('Colors List Contains='+colors);

    colors.add('Black');
    System.debug('Colors List Contains='+colors);

    List<String>colorsList2=new List<String>();
    colorsList2.add('White');
    colorsList2.add('Purple');
    colors.addAll(colorsList2);
    System.debug('Colors Contains List='+colors);
    System.debug('Colors Contains List2='+colorsList2);

    colorsList2.clear();
    System.debug('Colors Contains List2='+colorsList2);

    List<String>clonedList=new List<String>();
    clonedList=colors.clone();
    System.debug('Cloned List Contains='+clonedList);

    System.debug('Colors List Contains Red Color='+colors.Contains('Red'));
    System.debug('Colors List Contains Grey Color='+colors.Contains('Grey'));
    System.debug('Color :List Contains clonedList='+colors.equals(clonedList));
    System.debug('Colors List Contains='+colors.equals(clonedList));
    System.debug('Color List Contains='+colors.get(3));
    System.debug('Color List Contains='+colors.indexOf('Green'));
    System.debug('Empty='+colors.isEmpty());
    System.debug('Empty='+colorsList2.isEmpty());
    colors.remove(3);
    System.debug('Color List Contain='+colors);
    System.debug('Size='+colors.Size());
    System.debug('Size='+colorsList2.Size());
    colors.sort();
    System.debug('Sorted Value='+colors);
    
    }
}