public class JobApplicationAsyncService {

    @future
    public static void processApplications(Set<Id> appIds) {

        List<Job_Application__c> apps = [
            SELECT Id, Status__c
            FROM Job_Application__c
            WHERE Id IN :appIds
        ];

        for (Job_Application__c app : apps) {
            app.Status__c = 'Interviewing';
        }

        update apps;
    }
}