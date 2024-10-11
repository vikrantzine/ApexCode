public class DemoErrorLogRecords {
    public static void demoInsert(){
        Demo__c dm=new Demo__c();
        dm.Name='Demo1';
        dm.Tax__c='12343235';
        insert dm;
    }
}