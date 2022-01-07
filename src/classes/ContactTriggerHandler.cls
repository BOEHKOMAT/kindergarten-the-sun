/**
 * Created by Andrew on 25.12.2021.
 */

public with sharing class ContactTriggerHandler {
    final static String teacherRecordType = SObjectType.Contact.getRecordTypeInfosByName().get('Teacher').getName();
    final static String kidRecordType = SObjectType.Contact.getRecordTypeInfosByName().get('Kid').getName();
    final static String parentRecordType = SObjectType.Contact.getRecordTypeInfosByName().get('Parent').getName();

    final static String teacherRecordTypeId = SObjectType.Contact.getRecordTypeInfosByName().get('Teacher').getRecordTypeId();
    final static String kidRecordTypeId = SObjectType.Contact.getRecordTypeInfosByName().get('Kid').getRecordTypeId();
    final static String parentRecordTypeId = SObjectType.Contact.getRecordTypeInfosByName().get('Parent').getRecordTypeId();

    static Map<Id, Group__c> groupCapacities = new Map<Id, Group__c>([SELECT Id, Capacity__c FROM Group__c]);

    public static void handle(List<Contact> triggeredNewData, List<Contact> triggeredOldData, Map<Id, Contact> newMap, Map<Id, Contact> oldMap) {
        List<Contact> teachers = [
                SELECT Id, Name, Group_Number__c
                FROM Contact
                WHERE RecordTypeId = :teacherRecordTypeId
        ];

        Map<Id, Integer> groups = new Map<Id, Integer>();
        for (AggregateResult aggregateResult : [
                SELECT Group_Number__c groupId, COUNT(Id) kidsCount
                FROM Contact
                WHERE RecordTypeId = :kidRecordTypeId
                GROUP BY Group_Number__c
        ]) {
            groups.put((Id) aggregateResult.get('groupId'), (Integer) aggregateResult.get('kidsCount'));
        }

        String currentRecordType;
        for (Contact contact : triggeredNewData) {
            try {
                currentRecordType = SObjectType.Contact.getRecordTypeInfosById().get(contact.RecordTypeId).getName();
            } catch (NullPointerException e) {
                currentRecordType = null;
            }

            if (currentRecordType == teacherRecordType) {
                if (Trigger.isBefore) {

                }

                if (Trigger.isAfter){
                    if (contact.Group_Number__c != null) {
                        checkTeacherPerGroupRule(contact, teachers);
                    }
                }
            }

            if ((currentRecordType == kidRecordType)
                    && (contact.Group_Number__c != null)) {
                if (Trigger.isBefore){

                }

                if (Trigger.isAfter) {
                    if (Trigger.isInsert) {
                        checkGroupCapacity(contact, groups);
                    }
                    if (Trigger.isUpdate && contact.Group_Number__c != oldMap.get(contact.Id).Group_Number__c) {
                        checkGroupCapacity(contact, groups);
                    }
                }
            }

            if (currentRecordType == parentRecordType) {

            }
        }
    }

    private static void checkTeacherPerGroupRule(Contact contact, List<Contact> teachers) {
        Boolean flag = true;
        for (Contact current : teachers) {
            if (current.Group_Number__c == contact.Group_Number__c && current.Id != contact.Id) {
                contact.addError('The teacher ' + current.Name + ' already owns this group');
                flag = false;
            }
        }
        if (flag && Trigger.isUpdate) teachers.add(contact);
    }

    private static void checkGroupCapacity(Contact contact, Map<Id, Integer> kidsCountInGroups) {
        Id currentContactId = contact.Group_Number__c;
        if (kidsCountInGroups.get(currentContactId) > groupCapacities.get(currentContactId).Capacity__c) {
            contact.addError('Group is full');
        } else {
            kidsCountInGroups.put(currentContactId, kidsCountInGroups.get(currentContactId) + 1);
        }
    }

}