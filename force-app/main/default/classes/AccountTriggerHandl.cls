//Assignment-1
public with sharing class AccountTriggerHandl {
    //Question 1
    public static void convertBillingToShipping(List<Account>accList){
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
    public static void updateEngineeringToFinance(List<Account>accList, Map<Id,Account>oldMap){
        for(Account acc:accList){
            if(acc.Industry == 'Finance' && oldMap.get(acc.Id).Industry == 'Engineering'){
                acc.Active__c='Yes';
            }
        }
    }
    //Question 3
    public static void preventAccDeletion(Map<Id,Account>oldMap){
        for(Account acc:oldMap.values()){
            if(acc.Active__c=='Yes'){
                acc.addError('Cannot Delete Account, Please uncheck Active...');
            }
            Integer oppCount=[SELECT COUNT() FROM Opportunity WHERE AccountId=:acc.Id];
            if(oppCount>0){
                acc.addError('Cannot Delete an Account with associate Opportunity...');
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
    public static void updateConPhoneOnAccChange(List<Account>accList){
        List<Contact>conList=new List<Contact>();
        for(Account acc:accList){
            Account oldAcc=(Account)Trigger.oldMap.get(acc.Id);
            if(acc.Phone!=NULL && acc.Phone!=oldAcc.Phone){
                List<Contact>relCon=[SELECT Id, OtherPhone, HomePhone FROM Contact WHERE AccountId=:acc.Id];
                for(Contact con:relCon){
                    con.OtherPhone=oldAcc.Phone;
                    con.HomePhone= acc.Phone; 
                    conList.add(con);
                }
            }
        }
        if(!conList.isEmpty()){
            update conList;
        }
    }
    //Question 6
    public static void sendMailOnAccDeletion(Map<Id,Account>oldMap){
        List<Messaging.SingleEmailMessage>emails=new List<Messaging.SingleEmailMessage>();
        for(Account acc:oldMap.values()){
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
    public static void updateDescription(List<Account>accList){
        for(Account acc:accList){
            if(acc.Name!=NULL || acc.AccountNumber!=NULL || acc.Industry!=NULL){
                acc.Description='Test Account:' + acc.Name + ' Account Number:' + acc.AccountNumber + ' Industry:' + acc.Industry;
            }
        }
    }
}