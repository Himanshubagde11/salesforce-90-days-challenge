public class JobApplicationService {

    public static void printInterviewingApps() {
        List<Job_Application__c> apps = [
            SELECT Id, Name, Status__c
            FROM Job_Application__c
            WHERE Status__c = 'Interviewing'
            LIMIT 5
        ];

        System.debug(apps);
    }
}