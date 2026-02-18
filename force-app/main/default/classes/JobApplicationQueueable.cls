public class JobApplicationQueueable implements Queueable {

    private Set<Id> applicationIds;

    public JobApplicationQueueable(Set<Id> ids) {
        this.applicationIds = ids;
    }

    public void execute(QueueableContext context) {

        List<Job_Application__c> apps = [
            SELECT Id, Status__c, Queue_Processed__c
            FROM Job_Application__c
            WHERE Id IN :applicationIds
            AND Queue_Processed__c = false
        ];

        if (apps.isEmpty()) {
            return;
        }

        for (Job_Application__c app : apps) {
            app.Status__c = 'Interviewing';
            app.Queue_Processed__c = true;
        }

        update apps;

   
    }
}