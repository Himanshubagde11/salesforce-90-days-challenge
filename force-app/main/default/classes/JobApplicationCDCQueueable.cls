public class JobApplicationCDCQueueable implements Queueable {

    private Set<Id> jobAppIds;

    // Constructor
    public JobApplicationCDCQueueable(Set<Id> jobAppIds) {
        this.jobAppIds = jobAppIds;
    }

    public void execute(QueueableContext context) {

        List<Job_Application__c> apps = [
            SELECT Id, Name, Status__c, OwnerId
            FROM Job_Application__c
            WHERE Id IN :jobAppIds
        ];

        List<Task> tasksToCreate = new List<Task>();

        for (Job_Application__c app : apps) {

            if (app.Status__c == 'Interviewing') {

                Task t = new Task(
                    Subject = 'Follow up interview for ' + app.Name,
                    OwnerId = app.OwnerId,
                    WhatId = app.Id,
                    Status = 'Not Started',
                    Priority = 'Normal'
                );

                tasksToCreate.add(t);
            }
        }

        if (!tasksToCreate.isEmpty()) {
            insert tasksToCreate;
        }
    }
}