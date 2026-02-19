public with sharing class JobApplicationController {

    @AuraEnabled(cacheable=true)
    public static List<Job_Application__c> getApplications() {
        return [
            SELECT Id,
                   Name,
                   Position__c,
                   Status__c,
                   Applied_Date__c,
                   Interview_Date__c,
                   Company__r.Name
            FROM Job_Application__c
            ORDER BY CreatedDate DESC
        ];
    }

    @AuraEnabled
    public static void updateStatus(Id recordId, String newStatus) {

        Job_Application__c app = [
            SELECT Id, Status__c
            FROM Job_Application__c
            WHERE Id = :recordId
            LIMIT 1
        ];

        if(app.Status__c == 'Interviewing' && newStatus == 'Applied'){
            throw new AuraHandledException('Invalid status transition');
        }

        app.Status__c = newStatus;
        update app;
    }
}