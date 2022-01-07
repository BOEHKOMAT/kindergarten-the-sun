/**
 * Created by Andrew on 26.12.2021.
 */
@IsTest
public with sharing class TestGroupTeacher {
    /*static Id teacherRecordType = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Teacher').getRecordTypeId();
    static Id notTeacherRecordType = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Kid').getRecordTypeId();
    static List<Contact> contacts = new List<Contact>{
            new Contact(RecordTypeId = teacherRecordType, LastName = 'Teacher RT'),
            new Contact(RecordTypeId = notTeacherRecordType, LastName = 'Not Teacher RT'),
            new Contact(LastName = 'Without RT')
    };


    @IsTest static void TestRelateTeacherRecordTypeToGroup() {
        insert contacts;
        Group__c grWithTeacher = new Group__c(Teacher__c = contacts.get(0).Id);

        Test.startTest();
        Database.SaveResult result1 = Database.insert(grWithTeacher,false);
        Test.stopTest();

        System.assert(result1.isSuccess());

        System.assertEquals(0, result1.getErrors().size());

    }
    @IsTest static void TestRelateNotTeacherRecordTypeToGroup() {
        insert contacts;
        Group__c grWithNotTeacher = new Group__c(Teacher__c = contacts.get(1).Id);

        Test.startTest();
        Database.SaveResult result2 = Database.insert(grWithNotTeacher,false);
        Test.stopTest();

        System.assert(!result2.isSuccess());
        System.assertEquals('Contact record type must be a teacher', result2.getErrors().get(0).getMessage());
    }
    @IsTest static void TestRelateWithoutRecordTypeToGroup() {
        insert contacts;
        Group__c grWithout = new Group__c(Teacher__c = contacts.get(2).Id);

        Test.startTest();
        Database.SaveResult result3 = Database.insert(grWithout, false);
        Test.stopTest();

        System.assert(!result3.isSuccess());
        System.assertEquals('Contact record type must be a teacher', result3.getErrors().get(0).getMessage());
    }*/
}