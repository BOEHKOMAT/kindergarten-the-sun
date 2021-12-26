/**
 * Created by Andrew on 25.12.2021.
 */

public with sharing class GroupRelateTeacherHandler {

    public static void handle(List<Group__c> groupData){
        checkRecordType(groupData);
        checkTeacherPerGroupRule(groupData);
    }

    private static void checkRecordType(List<Group__c> newList) {
        String teacherRecordType = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Teacher').getName();

        List<Id> teacherId = new List<Id>();
        for (Group__c gr : newList) {
            teacherId.add(gr.Teacher__c);
        }

        List<Contact> teachers = [
                SELECT LastName, FirstName, RecordTypeId
                FROM Contact
                WHERE Id IN :teacherId
        ];

        for (Integer i = 0; i < teachers.size(); i++) {
            Contact teacher = teachers.get(i);
            if (newList.get(i).Teacher__c != null) {
                String currentRecordType;
                try {
                    currentRecordType = SObjectType.Contact.getRecordTypeInfosById().get(teacher.RecordTypeId).getName();
                } catch (NullPointerException e) {
                    currentRecordType = null;
                }
                if (currentRecordType == null || currentRecordType != teacherRecordType) {
                    newList.get(i).addError('Contact record type must be a teacher');
                }
            }
        }
    }

    private static void checkTeacherPerGroupRule(List<Group__c> groups) {
        List<Group__c> filteredGroups = new List<Group__c>();
        for (Group__c gr : groups) {
            if (gr.Teacher__c != null && gr.getErrors().size() == 0) {
                filteredGroups.add(gr);
            }
        }

        Set<Id> grIdSet = new Set<Id>();
        for(Group__c p : filteredGroups){
            grIdSet.add(p.Teacher__c);
        }
        for(Contact contact : [SELECT Name, (SELECT Id FROM Groups__r) FROM Contact WHERE Id IN:grIdSet ]){
            for(Group__c gr : filteredGroups){
                if(contact.Groups__r.size() > 0){
                    gr.addError(contact.Name + ' already has the group № ' + gr.Name);
                }
            }
        }

    }

}