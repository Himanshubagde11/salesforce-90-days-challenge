trigger JobApplicationTrigger on Job_Application__c (before update) {

    if(Trigger.isBefore && Trigger.isUpdate){
        JobApplicationTriggerHandler.beforeUpdate(
            Trigger.new,
            Trigger.oldMap
        );
    }

}