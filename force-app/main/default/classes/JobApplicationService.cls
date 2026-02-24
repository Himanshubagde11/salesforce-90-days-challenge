public with sharing class JobApplicationService {

    public static List<Job_Application__c> fetchApplications() {
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

    public static void updateStatusEngine(Id recordId, String newStatus) {

        Job_Application__c app = [
            SELECT Id, Status__c
            FROM Job_Application__c
            WHERE Id = :recordId
            LIMIT 1
        ];

        if(app.Status__c == 'Interviewing' && newStatus == 'Applied'){
            throw new AuraHandledException('Backward transition not allowed');
        }

        app.Status__c = newStatus;
        update app;

        Job_Status_Update__e eventMsg = new Job_Status_Update__e(
            RecordId__c = recordId,
            NewStatus__c = newStatus
        );

        EventBus.publish(eventMsg);

        AppLogger.log('Status updated for record: ' + recordId);
    }
}