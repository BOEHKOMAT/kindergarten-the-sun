/**
 * Created by Andrew on 26.12.2021.
 */


public with sharing class GroupController {
    @AuraEnabled(Cacheable=true)
    public static List<Contact> getRelatedKids(Id groupId) {
        return [
                SELECT Id, FirstName, LastName, Phone
                FROM Contact
                WHERE RecordTypeId = :SObjectType.Contact.getRecordTypeInfosByName().get('Kid').getRecordTypeId()
                AND Group_Number__c = :groupId
        ];
    }
}