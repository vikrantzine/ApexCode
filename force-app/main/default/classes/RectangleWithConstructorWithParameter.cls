public class RectangleWithConstructorWithParameter {
    Decimal length,breadth;
    
	//Constructor
    public RectangleWithConstructorWithParameter(Decimal l,Decimal b){
        length=l;
        breadth=b;
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