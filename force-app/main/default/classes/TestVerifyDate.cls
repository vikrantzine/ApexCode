@isTest
public with sharing class TestVerifyDate {
    @isTest
    public static void testDateWithin30Days(){
        Date date1=Date.Today();
        Date date2=date1.addDays(15);
        Date result=VerifyDate.CheckDates(date1, date2);
        System.assertEquals(date2, result, 'Expected date2 to be returned...');
    }
    @isTest
    public static void testDateOutside30Days(){
        Date date1=date.today();
        Date date2=date1.addDays(-5);
        Date result=VerifyDate.CheckDates(date1, date2);
        Date expectedEndOfMonth=Date.newInstance(date1.year(), date1.month(), Date.daysInMonth(date1.year(), date1.month()));
        System.assertEquals(expectedEndOfMonth, result, 'Expected End of month date to be returned...');
    }
}