public class Rectangle {
    
    //Method 1
    public void area(){
        Decimal length=5.5,breadth=10;		//Variable Creation
        Decimal a=length*breadth;
        System.debug('Area='+a);
    }
    
    //Method 2
    public void perimeter(){
        Decimal length=5.5,breadth=10;		//Variable Creation
        Decimal a=2*(length*breadth);
        System.debug('Perimeter='+a);
    }
}