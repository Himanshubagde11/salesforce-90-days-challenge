public class JobApplicationTriggerHandler {

    public static void beforeInsert(List<Job_Application__c> newRecords) {
        System.debug('Before Insert Trigger Fired');

        for (Job_Application__c app : newRecords) {
            // example safe logic
            if (TriggerBypass.skipJobApplicationTrigger) {
    return;
}

if (app.Status__c == null) {
    app.Status__c = 'Applied';
}

        }
    }

    public static void beforeUpdate(
        List<Job_Application__c> newRecords,
        Map<Id, Job_Application__c> oldMap
    ) {
        System.debug('Before Update Trigger Fired');
    }
}