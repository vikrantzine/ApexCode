public class RecordComparison {

    public static String compareRecords(Id ob1Id) {
        // Fetch the Ob1__c record
        Ob1__c ob1Record = [SELECT Name, Descr1__c FROM Ob1__c WHERE Id = :ob1Id];

        // Fetch related Ob2__c and Ob3__c records
        List<Ob2__c> ob2Records = [SELECT Name, Ob1__c, Descr2__c FROM Ob2__c WHERE Ob1__c = :ob1Id];
        List<Ob3__c> ob3Records = [SELECT Name, Ob1__c, Ob2__c, Descr3__c FROM Ob3__c WHERE Ob1__c = :ob1Id];

        Boolean matchFound = false;

        // Compare Ob1__c with Ob2__c child records
        for (Ob2__c ob2Record : ob2Records) {
            if (ob1Record.Descr1__c == ob2Record.Descr2__c) {
                matchFound = true;
            }
        }

        // If match is found in Ob2__c records, check Ob3__c records
        if (matchFound) {
            for (Ob2__c ob2Record : ob2Records) {
                for (Ob3__c ob3Record : ob3Records) {
                    if (ob2Record.Descr2__c == ob3Record.Descr3__c) {
                        return 'Record is Matched';
                    }
                }
            }
        }

        return 'Record not matched';
    }
}