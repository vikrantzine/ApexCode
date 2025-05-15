public class BulkDeleteOpp {
    public static void deleteOpp(){
        List<Opportunity>oppList=[SELECT Id, Name FROM Opportunity WHERE Name LIKE '%Opp%'];
        delete oppList;
    }
}