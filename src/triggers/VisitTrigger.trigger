/**
 * Created by Andrew on 07.01.2022.
 */

trigger VisitTrigger on Visit__c (before insert) {
    VisitTriggerHandler.handle(Trigger.new, Trigger.newMap);
}