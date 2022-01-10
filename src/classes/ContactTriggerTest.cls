/**
 * Created by Andrew on 10.01.2022.
 */

@IsTest
private class ContactTriggerTest {

    @IsTest
    static void TestCheckGroupRule() {
        Group__c testGr = TestDataFactory.createGroup(3);
        List<Contact> teachers = TestDataFactory.createTeachers(2);


        Database.SaveResult result1, result2;

        teachers.get(0).Group_Number__c = testGr.Id;
        teachers.get(1).Group_Number__c = testGr.Id;

        Test.startTest();
        result1 = Database.update(teachers.get(0));
        result2 = Database.update(teachers.get(1), false);
        Test.stopTest();

        System.assert(result1.isSuccess());

        System.assert(!result2.isSuccess());
        System.debug(result2.errors[0].getMessage());
    }

    @IsTest
    static void TestGroupCapacity() {
        Group__c testGr = TestDataFactory.createGroup(3);
        Group__c anotherGr = TestDataFactory.createGroup(10);
        List<Contact> kids = TestDataFactory.createKids(4,testGr.Id);

        Contact rejectedKid = kids.get(3);

        Test.startTest();
        Database.SaveResult[] insertResults = Database.insert(kids, false);
        rejectedKid.Group_Number__c = null;
        Database.SaveResult insertResult = Database.insert(rejectedKid);
        rejectedKid.Group_Number__c = anotherGr.Id;
        Database.SaveResult updateResult = Database.update(rejectedKid);
        Test.stopTest();

        for (Database.SaveResult result : insertResults) {
            if (result.isSuccess()) {
                System.assert(result.isSuccess());
            } else {
                System.debug(result.errors[0].getMessage());
            }
        }

        System.assert(insertResult.isSuccess());

        System.assert(updateResult.isSuccess());
    }
}