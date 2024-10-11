public class Square{ 
    Decimal a;
    
    //Default Constructor
    public Square(){
        a=10;
    }
    
    //Method
    public void area(){
        Decimal area=a*a;
        system.debug('Area='+area);
    }
    
    //Method
    public void perimeter(){
        Decimal per= 4 * a;
        system.debug('Perimeter='+per);
    }
}