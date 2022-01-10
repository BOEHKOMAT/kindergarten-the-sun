/**
 * Created by Andrew on 10.01.2022.
 */

@IsTest
private class GroupControllerTest {
    @IsTest
    static void TestGetRelatedKids() {
        Group__c testGroup = TestDataFactory.createGroup(10);
        List<Contact> kids = TestDataFactory.createKids(4,testGroup.Id);
        insert kids;

        for (Contact kid: GroupController.getRelatedKids(testGroup.Id)){
            System.assertEquals(testGroup.Id ,kid.Group_Number__c);
        }
    }

    @IsTest
    static void TestGetTopKid() {

    }
}