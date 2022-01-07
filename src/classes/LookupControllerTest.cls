@IsTest
public with sharing class LookupControllerTest {


    @IsTest
    private static void getAllAccount(){
        List<Account> accountsInSystem = [SELECT Id, Name FROM Account];
        System.assertEquals(2, accountsInSystem.size());

        Test.startTest();
            List<SObject> results = LookupController.lookUp('', 'Account', '', '', 'Id, Name');
            System.assertEquals(2, results.size());
        Test.stopTest();

    }

    @IsTest
    private static void searchAccountWithKeyword(){
        List<Account> accountsInSystem = [SELECT Id, Name FROM Account];
        System.assertEquals(2, accountsInSystem.size());

        Test.startTest();
            List<SObject> results = LookupController.lookUp('Test', 'Account', '', '', 'Id, Name');
            System.assertEquals(1, results.size());
            System.assertEquals('Test Account', results[0].get('Name'));
        Test.stopTest();
    }

    @IsTest
    private static void searchAccountWithId(){
        List<Account> accountsInSystem = [SELECT Id, Name FROM Account];
        System.assertEquals(2, accountsInSystem.size());

        Test.startTest();
            List<SObject> results = LookupController.lookUp('', 'Account', '', accountsInSystem[0].Id, 'Id, Name');
            System.assertEquals(1, results.size());
            System.assertEquals(accountsInSystem[0].Id, results[0].get('Id'));
        Test.stopTest();
    }

    @IsTest
    private static void searchAccountWithFilters(){
        List<Account> accountsInSystem = [SELECT Id, Name FROM Account];
        System.assertEquals(2, accountsInSystem.size());

        Test.startTest();
            String filters = 'Name = \'Test Account\'';
            List<SObject> results = LookupController.lookUp('', 'Account', filters , '', 'Id, Name');
            System.assertEquals(1, results.size());
            System.assertEquals('Test Account', results[0].get('Name'));
        Test.stopTest();
    }

    @TestSetup
    private static void setupDate(){
        //generate two accounts with basic information
        List<Account> accountsToBeInserted = new List<Account>();
        accountsToBeInserted.add(new Account(Name = 'Search Account'));
        accountsToBeInserted.add(new Account(Name = 'Test Account'));
        insert accountsToBeInserted;
    }
}