global class JobApplicationBatch implements Database.Batchable<sObject> {

    global Database.QueryLocator start(Database.BatchableContext bc) {

        return Database.getQueryLocator([
            SELECT Id, Status__c, Applied_Date__c, Interview_Date__c, Is_Active__c
            FROM Job_Application__c
            WHERE Is_Active__c = true
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