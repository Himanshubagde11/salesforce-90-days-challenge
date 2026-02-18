global class JobApplicationBatch
    implements Database.Batchable<SObject> {

    global Database.QueryLocator start(Database.BatchableContext bc) {

        return Database.getQueryLocator([
            SELECT Id, Status__c
            FROM Job_Application__c
            WHERE Status__c = 'Applied'
        ]);
    }

    global void execute(
        Database.BatchableContext bc,
        List<Job_Application__c> scope
    ) {
        for (Job_Application__c app : scope) {
            app.Status__c = 'Interviewing';
        }
        update scope;
    }

    global void finish(Database.BatchableContext bc) {

        if (Test.isRunningTest()) {
            return;
        }

    }
}