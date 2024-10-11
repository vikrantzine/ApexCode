public class SquareWithStaticWithPerimeter {
    
    //Method1
    public static void area(Decimal a){
        Decimal area;
        area = a * a;
        system.debug('Area='+area);
    }
    
    //Method2
    public static void perimeter(Decimal a){
        Decimal peri;
        peri=4*a;
        system.debug('Perimeter='+peri);
    }
}