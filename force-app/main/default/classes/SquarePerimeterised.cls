public class SquarePerimeterised {
    Decimal a;
    
    //Perimeterized Constructor
    public SquarePerimeterised(Decimal a){
        this.a=a;
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