global class JobApplicationStatefulBatch
implements Database.Batchable<SObject>, Database.Stateful {

    global Integer totalProcessed = 0;

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Id, Status__c FROM Job_Application__c WHERE Status__c = \'Applied\''
        );
    }

    global void execute(
        Database.BatchableContext bc,
        List<Job_Application__c> scope
    ) {
        for (Job_Application__c app : scope) {
            app.Status__c = 'Interviewing';
            totalProcessed++;
        }
        update scope;
    }

    global void finish(Database.BatchableContext bc) {
        System.debug('Total records processed: ' + totalProcessed);
    }
}