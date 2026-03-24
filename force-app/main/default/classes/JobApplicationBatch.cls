global class JobApplicationBatch implements Database.Batchable<sObject> {

    global Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator([
        SELECT Id, Name, Status__c
        FROM Job_Application__c
        WHERE Is_Active__c = true
        AND (Callout_Status__c = null 
             OR Callout_Status__c = 'Failed')
        AND (Retry_Count__c = null OR Retry_Count__c < 3)
    ]);
}

    global void execute(Database.BatchableContext bc, List<Job_Application__c> scope) {

        List<Job_Application__c> updates = new List<Job_Application__c>();

        for(Job_Application__c app : scope){

            if(app.Status__c == 'Applied' && app.Applied_Date__c != null){

                if(app.Applied_Date__c.addDays(30) < Date.today()){
                    app.Status__c = 'Rejected';
                    app.Is_Active__c = false;
                    updates.add(app);
                }

            }

            if(app.Status__c == 'Interviewing' && app.Interview_Date__c != null){

                if(app.Interview_Date__c.addDays(7) < Date.today()){
                    app.Is_Active__c = false;
                    updates.add(app);
                }

            }

        }

        if(!updates.isEmpty()){
            update updates;
        }

    }

    global void finish(Database.BatchableContext bc){

        System.debug('Batch Job Finished');

    }
}