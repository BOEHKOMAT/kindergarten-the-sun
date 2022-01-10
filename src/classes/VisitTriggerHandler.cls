/**
 * Created by Andrew on 07.01.2022.
 */

public with sharing class VisitTriggerHandler {
    public static void handle(List<Visit__c> newList, Map<Id, Visit__c> newMap) {
        Map<Id, Visit__c> visits = new Map<Id, Visit__c>();
        for (Visit__c visit : [SELECT Kid__c, CreatedDate FROM Visit__c WHERE CreatedDate = TODAY]) {
            visits.put(visit.Kid__c, visit);
        }

        for (Visit__c visit : newList) {
            if (visits.containsKey(visit.Kid__c)) {
                visit.addError('Kid has already been marked as present today');
            }
        }
    }
}