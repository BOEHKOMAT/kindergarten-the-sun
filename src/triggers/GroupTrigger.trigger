/**
 * Created by Andrew on 25.12.2021.
 */

trigger GroupTrigger on Group__c (before insert, before update) {
    GroupRelateTeacherHandler.handle(Trigger.new);
//    GroupRelateTeacherHandler.checkTeacherPerGroupRule(Trigger.new);
}


// getRecordTypeInfosByDeveloperName={Kid=Schema.RecordTypeInfo[getDeveloperName=Kid;
// getName=Kid;getRecordTypeId=0127Q000000t4wPQAQ;isActive=true;isAvailable=true;
// isDefaultRecordTypeMapping=false;isMaster=false;],
// Master=Schema.RecordTypeInfo[getDeveloperName=Master;
// getName=Master;getRecordTypeId=012000000000000AAA;
// isActive=true;isAvailable=true;isDefaultRecordTypeMapping=false;isMaster=true;],
// Parent=Schema.RecordTypeInfo[getDeveloperName=Parent;getName=Parent;getRecordTypeId=0127Q000000t4wUQAQ;isActive=true;
// isAvailable=true;isDefaultRecordTypeMapping=true;isMaster=false;],
// Teacher=Schema.RecordTypeInfo[getDeveloperName=Teacher;getName=Teacher;
// getRecordTypeId=0127Q000000t4wZQAQ;isActive=true;isAvailable=true;
// isDefaultRecordTypeMapping=false;isMaster=false;]};