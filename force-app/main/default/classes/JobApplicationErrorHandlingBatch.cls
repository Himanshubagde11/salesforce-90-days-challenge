public class JobApplicationErrorHandlingBatch
    implements Database.Batchable<SObject> {

    public Database.QueryLocator start(Database.BatchableContext bc) {

        return Database.getQueryLocator(
            'SELECT Id, Status__c, Interview_Date__c, Position__c ' +
            'FROM Job_Application__c ' +
            'WHERE Status__c = \'Applied\''
        );
    }

    public void execute(Database.BatchableContext bc, List<Job_Application__c> scope) {

        List<Job_Application__c> toUpdate = new List<Job_Application__c>();

        for (Job_Application__c app : scope) {

            app.Status__c = 'Interviewing';

            // REQUIRED BY VALIDATION RULES
            app.Interview_Date__c = Date.today().addDays(1);
            app.Position__c = 'Software Engineer';

            toUpdate.add(app);
        }

        if (!toUpdate.isEmpty()) {
            update toUpdate;
        }
    }

    public void finish(Database.BatchableContext bc) {
        // nothing needed
    }
}