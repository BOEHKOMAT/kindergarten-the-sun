/**
 * Created by Andrew on 26.12.2021.
 */


public with sharing class GroupController {
    @AuraEnabled(Cacheable=true)
    public static List<Contact> getRelatedKids(Id groupId) {
        return [
                SELECT Id, Name, Phone, Group_Number__c
                FROM Contact
                WHERE RecordTypeId = :SObjectType.Contact.getRecordTypeInfosByName().get('Kid').getRecordTypeId()
                AND Group_Number__c = :groupId
        ];
    }

    @AuraEnabled(Cacheable=true)
    public static List<Contact> getTopKid(Id groupId, Boolean month) {

        Map<Id, Integer> visitMap = new Map<Id, Integer>();
        for (AggregateResult result : month ? [
                SELECT Kid__c kids, COUNT(CreatedDate) counts
                FROM Visit__c
                WHERE CreatedDate = THIS_MONTH
                AND Kid__r.Group_Number__r.Id = :groupId
                GROUP BY Kid__c
        ] : [
                SELECT Kid__c kids, COUNT(CreatedDate) counts
                FROM Visit__c
                WHERE CreatedDate = THIS_WEEK
                AND Kid__r.Group_Number__r.Id = :groupId
                GROUP BY Kid__c
        ]) {
            visitMap.put((Id) result.get('kids'), (Integer) result.get('counts'));
        }

        Id topKid = visitMap.isEmpty() ? null : new List<Id>(visitMap.keySet())[0];
        for (Id kid : visitMap.keySet()) {
            topKid = visitMap.get(kid) > visitMap.get(topKid) ? kid : topKid;
        }

        return [
                SELECT LastName, FirstName
                FROM Contact
                WHERE Id = :topKid
        ];
    }
}