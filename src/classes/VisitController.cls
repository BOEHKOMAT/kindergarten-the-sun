/**
 * Created by Andrew on 07.01.2022.
 */

public with sharing class VisitController {
    @AuraEnabled(Cacheable=true)
    public static List<Visit__c> getGroupVisitsToday(Id groupId) {
        return [
                SELECT Kid__r.LastName, Parent__r.LastName, CreatedDate
                FROM Visit__c
                WHERE Kid__r.Group_Number__c = :groupId
                AND Kid__r.RecordTypeId = :SObjectType.Contact.getRecordTypeInfosByName().get('Kid').getRecordTypeId()
                AND CreatedDate = TODAY
        ];
    }
}