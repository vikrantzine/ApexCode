public with sharing class WireSObjects {
@AuraEnabled(cacheable=true)
    public static List<string> getSObjectNames(){
    Map<String,Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
    List<String>sObjectNames=new List<String>();
        for(String sObjectName : schemaMap.keySet()){
            sObjectNames.add(schemaMap.get(sObjectName).getDescribe().getName());
        }
        sObjectNames.sort();
        return sObjectNames;
    }

@AuraEnabled(cacheable=true)
    public static List<Map<String,String>> getFieldsOfSobject(String sObjectName){
        if(String.isEmpty(sObjectName)) 
        return new List<Map<String,String>>();
        Map<String,Schema.SObjectField> fieldMap=Schema.getGlobalDescribe().get(sObjectName).getDescribe().fields.getMap();
        List<Map<String,String>> fields=new List<Map<String,String>>();
        for(String fieldName:fieldMap.keySet()){
            Map<String,String> fieldInfo=new Map<String,String>();
            fieldInfo.put('label', fieldMap.get(fieldName).getDescribe().getLabel());
            fieldInfo.put('value', fieldName);
            fields.add(fieldInfo);
        }
        return fields;
    }

@AuraEnabled(cacheable=true)
    public static List<Map<String,Object>> getRecords(String sObjectName, List<String> fieldNames){
        if(String.isEmpty(sObjectName) || fieldNames.isEmpty())
        return new List<Map<String,Object>>();
        String query = 'SELECT ' + String.join(fieldNames, ',') + ' FROM ' + sObjectName;
        List<SObject> records=Database.query(query);
        List<Map<String,Object>>result=new List<Map<String,Object>>();
        for(SObject record:records){
            Map<String,Object>recordMap=new Map<String,Object>();
            for(String field:fieldNames){
                recordMap.put(field, record.get(field));
            }
            result.add(recordMap);
        }
        return result;
    }
}