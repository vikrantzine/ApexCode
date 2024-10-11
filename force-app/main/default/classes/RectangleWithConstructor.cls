public class RectangleWithConstructor {
    Decimal length,breadth;
    
	//Constructor
    public RectangleWithConstructor(){
        length=5.5;
        breadth=10;
    }

	//Method 1
    public void area(){
		Decimal a=length*breadth;
        System.debug('Area='+a);
    }   
    
    //Method 2
    public void perimeter(){
        Decimal length=5.5,breadth=10;
        Decimal a=2*(length*breadth);
        System.debug('Perimeter='+a);
    }
}