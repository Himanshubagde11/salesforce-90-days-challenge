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

        Map<String, Integer> orderMap = new Map<String, Integer>{
            'Applied' => 1,
            'Interviewing' => 2,
            'Offered' => 3,
            'Rejected' => 4
        };

        if(orderMap.containsKey(app.Status__c) &&
           orderMap.containsKey(newStatus) &&
           orderMap.get(newStatus) < orderMap.get(app.Status__c)) {
            throw new AuraHandledException('Backward status transition not allowed');
        }

        app.Status__c = newStatus;
        update app;

        Job_Status_Update__e eventObj = new Job_Status_Update__e(
            RecordId__c = recordId,
            NewStatus__c = newStatus
        );

        EventBus.publish(eventObj);
    }
}