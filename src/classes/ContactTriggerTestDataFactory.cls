/**
 * Created by Andrew on 10.01.2022.
 */

@IsTest
public class ContactTriggerTestDataFactory {

    final static String teacherRecordTypeId = SObjectType.Contact.getRecordTypeInfosByName().get('Teacher').getRecordTypeId();
    final static String kidRecordTypeId = SObjectType.Contact.getRecordTypeInfosByName().get('Kid').getRecordTypeId();
    final static String parentRecordTypeId = SObjectType.Contact.getRecordTypeInfosByName().get('Parent').getRecordTypeId();
    final static String teacherId = '0057Q000002OPaKQAW';

    public static List<Contact> createTeachers(Integer count) {
        List<Contact> teachers = new List<Contact>();
        for(Integer i=0;i<count;i++) {
            Contact contact = new Contact(LastName='Teacher' + i, RecordTypeId=teacherRecordTypeId, User__c=teacherId);
            teachers.add(contact);
        }
        insert teachers;
        return teachers;
    }

    public static List<Contact> createKids(Integer count) {
        List<Contact> kids = new List<Contact>();
        for(Integer i=0;i<count;i++) {
            Contact contact = new Contact(LastName='Kid' + i, RecordTypeId=kidRecordTypeId);
            kids.add(contact);
        }
        return kids;
    }

    public static Group__c createGroup(Integer capacity) {
        Group__c gr = new Group__c(Capacity__c = capacity);
        insert gr;
        return gr;
    }
}