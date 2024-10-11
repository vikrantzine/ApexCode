@IsTest
private class AccountWrapperTests {

    @TestSetup
    static void loadTestData() {
        // Create an Account
        Account acct = new Account(Name = 'ACME');
        insert acct;

        // Create Opportunities for that account
        List<Opportunity> opps = new List<Opportunity>();
        for (Integer i = 0; i < 5; i++) {
            opps.add(new Opportunity(
                Name = 'Opportunity ' + i,
                StageName = 'Prospecting',
                CloseDate = Date.today().addDays(30),
                Amount = 1000.00,
                AccountId = acct.Id
            ));
        }
        insert opps;
    }

    @IsTest
    static void testPositiveRoundedAveragePrice() {
        // Test the rounded average opportunity price
        Account acct = [SELECT Id FROM Account LIMIT 1];
        AccountWrapper acctWrapper = new AccountWrapper(acct);

        Test.startTest();
        Assert.areEqual(
            1000.00,
            acctWrapper.getRoundedAvgPriceOfOpps(),
            'Expected to get 1000.00'
        );
        Test.stopTest();
    }

    @IsTest
    static void testIsHighPriority() {
        // Test isHighPriority method
        Account acct = [SELECT Id FROM Account LIMIT 1];
        AccountWrapper acctWrapper = new AccountWrapper(acct);

        // Test where opportunities have low amounts (should return false)
        Test.startTest();
        Boolean result = acctWrapper.isHighPriority();
        Test.stopTest();

        // Assert that the account is not high priority
        Assert.isFalse(result, 'Expected high priority to return false');
    }

    @IsTest
    static void testNoOpportunitiesThrowsException() {
        // Create an account with no opportunities
        Account acct = new Account(Name = 'No Opportunities');
        insert acct;

        AccountWrapper acctWrapper = new AccountWrapper(acct);

        // Test that exception is thrown when there are no opportunities
        Test.startTest();
        try {
            acctWrapper.getRoundedAvgPriceOfOpps();
            System.assert(false, 'Expected an AWException to be thrown');
        } catch (AccountWrapper.AWException e) {
            System.assertEquals('No won Opportunities', e.getMessage(), 'Expected error message not found');
        }
        Test.stopTest();
    }

    @IsTest
    static void testLowAvgAmount() {
        // Create an account with opportunities having a low average amount
        Account acct = [SELECT Id FROM Account LIMIT 1];
        List<Opportunity> opps = [SELECT Id, Amount FROM Opportunity WHERE AccountId = :acct.Id];
        
        // Set opportunity amounts to a low value
        for (Opportunity opp : opps) {
            opp.Amount = 10.00;
        }
        update opps;

        AccountWrapper acctWrapper = new AccountWrapper(acct);

        // Test that the average price is rounded correctly and high priority returns false
        Test.startTest();
        Decimal avgPrice = acctWrapper.getRoundedAvgPriceOfOpps();
        Boolean isHighPriority = acctWrapper.isHighPriority();
        Test.stopTest();

        Assert.areEqual(0.00, avgPrice, 'Expected rounded average to be 0.00');
        Assert.isFalse(isHighPriority, 'Expected high priority to be false for low average price');
    }
}