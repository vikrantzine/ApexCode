//Assignment-1
public with sharing class AccountTriggerHandl {
    //Question 1
    public static void convertBillingToShipping(List<Account> accList){
        for(Account acc:accList){
                acc.ShippingStreet=acc.BillingStreet;
                acc.ShippingCity=acc.BillingCity;
                acc.ShippingPostalCode=acc.BillingPostalCode;
                acc.ShippingState=acc.BillingState;
                acc.ShippingCountry=acc.BillingCountry;
                acc.Industry='Engineering';
        }
    }

    //Question 2
    public static void updateEngineeringToFinance(List<Account> accList, Map<Id,Account> oldMap){
        for(Account acc:accList){
            if(acc.Industry == 'Finance' && oldMap.get(acc.Id).Industry == 'Engineering'){
                acc.Active__c='Yes';
            }
        }
    }

    //Question 3
    public static void preventAccDeletion(List<Account> accList){
        Set<Id>accSet=new Set<Id>();
        for(Account acc:accList){
            accSet.add(acc.Id);
            if(acc.Active__c=='Yes'){
                acc.addError('Please check your Account Status is Active...');
            }
        }
        List<Opportunity>oppList=[SELECT Id,AccountId FROM Opportunity WHERE AccountId =:accSet];
        if(!oppList.isEmpty()){
            for(Account acc:accList){
                acc.addError('Please Check Your Account Have Related Opportunity...');
            }
        }
    }

    //Question 4
    public static void createTaskForHighRevenue(List<Account> accList){
        List<Task>taskList=new List<Task>();
        for(Account acc:accList){
            if(acc.AnnualRevenue!=NULL && acc.AnnualRevenue>50000){
                Task tsk=new Task();
                tsk.Subject='Follow Up Task with High AnnualRevenue';
                tsk.WhatId=acc.Id;
                tsk.Status='Not Started';
                tsk.Priority='Normal';
                taskList.add(tsk);
            }
        }
        if(!taskList.isEmpty()){
            insert taskList;
        }
    }

    //Question 5
    public static void updateConPhoneOnAccChange(List<Account> accList, Map<Id,Account> oldMap){
        Set<Id>accId=new Set<Id>();
        List<Contact>conList=new List<Contact>();
        for(Account acc:accList){
            Account ac = oldmap.get(acc.id);
            if( ac.Phone != Null && ac.Phone != acc.Phone){
                accid.add(acc.id);
            }
        }
        list<Contact> conl=[select Id,AccountId from Contact where AccountId=: accid];
            if(!conl.isEmpty()){
                for( Contact  CON : conl){
                    for( Account ac: accList){
                    Account acc = oldmap.get(ac.id);
                        con.HomePhone=acc.Phone;
                        con.OtherPhone=ac.Phone;
                        conList.add(con);
                    }
                }
            }
            if(!conList.isEmpty()){
                update conList;
            }
    }

    //Question 6
    public static void sendMailOnAccDeletion(List<Account> accList){
        List<Messaging.SingleEmailMessage>emails=new List<Messaging.SingleEmailMessage>();
        for(Account acc:accList){
            Messaging.SingleEmailMessage email=new Messaging.SingleEmailMessage();
            email.setToAddresses(New String[] {'vikrantzine@gmail.com'});
            email.setSubject('Account Deleted '+acc.Name);
            email.setPlainTextBody('The Account '+acc.Name+' Has been Deleted...');
            emails.add(email);
        }
        if(!emails.isEmpty()){
            Messaging.sendEmail(emails);
        }
    }

    //Task of Mentor 1
    public static void updateDescription(List<Account> accList){
        for(Account acc:accList){
            if(acc.Name!=NULL || acc.AccountNumber!=NULL || acc.Industry!=NULL){
                acc.Description='Test Account:' + acc.Name + ' Account Number:' + acc.AccountNumber + ' Industry:' + acc.Industry;
            }
        }
    }

    //Task 3
    public static void updatePhoneAndRelatedContact(List<Account> accList, Map<Id, Account> oldAccountMap) {
        Map<String, String> countryCodeMap = new Map<String, String>();
        //Custom Metadata
        for (Country_Code__mdt countryCodeMdt : [SELECT Country__c, Phone_Code__c FROM Country_Code__mdt]) {
            countryCodeMap.put(countryCodeMdt.Country__c, countryCodeMdt.Phone_Code__c);
        }

        Map<Id, String> accountCountryCodes = new Map<Id, String>();

        for (Account acc : accList) {
            Account oldAcc = oldAccountMap != null ? oldAccountMap.get(acc.Id) : null;

            Boolean countryChanged = oldAcc != null && (oldAcc.BillingCountry != acc.BillingCountry || oldAcc.ShippingCountry != acc.ShippingCountry);

            if (acc.Phone != null || countryChanged) {
                String countryCode = countryCodeMap.get(acc.BillingCountry);
                if (countryCode == null) {
                    countryCode = countryCodeMap.get(acc.ShippingCountry);
                }

                if (countryCode != null) {
                    String existingNumber = acc.Phone != null ? acc.Phone.replaceAll('^\\+\\d+\\s+', '') : ''; //Remove prev country code
                    acc.Phone = countryCode + ' ' + existingNumber;
                    accountCountryCodes.put(acc.Id, countryCode);
                }
            }
        }

        //Update rel Contact phone
        if (!accountCountryCodes.isEmpty()) {
            List<Contact> contactsToUpdate = new List<Contact>();

            for (Contact c : [SELECT Id, Phone, AccountId FROM Contact WHERE AccountId IN :accountCountryCodes.keySet()]) {
                String countryCode = accountCountryCodes.get(c.AccountId);
                if (countryCode != null) {
                    String existingNumber = c.Phone != null ? c.Phone.replaceAll('^\\+\\d+\\s+', '') : ''; //Remove prev country code
                    c.Phone = countryCode + ' ' + existingNumber;
                    contactsToUpdate.add(c);
                }
            }

            if (!contactsToUpdate.isEmpty()) {
                try {
                    update contactsToUpdate;
                } catch (DmlException e) {
                    System.debug('Failed to update contacts: ' + e.getMessage());
                }
            }
        }
    }

    //Task 4
    public static void updateAccRelContact(List<Account> accList){
        List<Account>acList=[SELECT Id, (SELECT Id FROM Contacts) FROM Account];
        for(Account acc:accList){
            
        }
    }

    //Task 5
    public static void insertAccRelCon(List<Account> accList){
        List<Contact>conList=new List<Contact>();
        for(Account acc:accList){
            if(acc.Number_of_Contact__c != NULL){
                for(Integer i=1;i<=acc.Number_of_Contact__c;i++){
                    Contact con=new Contact();
                    con.AccountId=acc.Id;
                    con.LastName='Con'+i;
                    conList.add(con);
                }
            }
        }
        if(!conList.isEmpty()){
            insert conList;
        }
    }

    //Task 2 Try
    public static void countCon(List<Account> accList){
        Set<Id>accIds=new Set<Id>();
        for(Account acc:accList){
            accIds.add(acc.Id);
        }
        List<Contact>conList=[SELECT Id,AccountId FROM Contact WHERE AccountId IN:accIds];
        for(Account ac:accList){
            ac.Count_Number_Of_Contact__c=conList.size();
        }
    }

    //Task 6
    public static void updateRelConName(List<Account> accList, Map<Id,Account> oldAc, Map<Id,Account> newAc){
        Set<Id>accIds=new Set<Id>();
        List<Contact>conList=new List<Contact>();
        for(Account acc:accList){
            Account oldAcc=oldAc.get(acc.Id);
            if(acc.Name != oldAcc.Name)
            accIds.add(acc.Id);
        }
        List<Contact>relCon=[SELECT Id,AccountId FROM Contact WHERE AccountId IN:accIds];
        for(Contact con:relCon){
            Account newAcc=newAc.get(con.AccountId);
            if(newAcc!=Null){
                con.LastName=newAcc.Name;
                con.AccountId=newAcc.Id;
                conList.add(con);
            }
        }
        if(!conList.isEmpty()){
            update conList;
        }
    }
}