trigger JobApplicationTrigger on Job_Application__c (before update, after update) {

    if(Trigger.isBefore && Trigger.isUpdate){
        JobApplicationTriggerHandler.handleBeforeUpdate(
            Trigger.new,
            Trigger.oldMap
        );
    }

    if(Trigger.isAfter && Trigger.isUpdate){
        JobApplicationTriggerHandler.handleAfterUpdate(
            Trigger.new,
            Trigger.oldMap
        );
    }
}