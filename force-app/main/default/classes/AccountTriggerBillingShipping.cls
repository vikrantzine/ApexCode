public with sharing class AccountTriggerBillingShipping {
    public static void billingShipping(List<Account>accList) {
        for (Account acc : accList) {
            if(acc.BillingCity!=null && acc.BillingState!=null){
                acc.ShippingCity=acc.BillingCity;
                acc.ShippingState=acc.BillingState;
            }
        }
    }
}