public with sharing class JobApplicationService {

    public static List<Job_Application__c> getApplications(
        Datetime lastCreatedDate,
        Integer pageSize
    ) {

        if (pageSize == null || pageSize <= 0) {
            pageSize = 5;
        }

        String baseQuery =
            'SELECT Id, Name, Position__c, Status__c, Applied_Date__c, ' +
            'Interview_Date__c, Company__r.Name, CreatedDate, Is_Active__c ' +
            'FROM Job_Application__c ';

        if (lastCreatedDate != null) {
            baseQuery +=
                'WHERE CreatedDate < :lastCreatedDate ';
        }

        baseQuery +=
            'ORDER BY CreatedDate DESC LIMIT :pageSize';

        return Database.query(baseQuery);
    }


    public static void updateStatusEngine(Id recordId, String newStatus) {

        if (recordId == null || String.isBlank(newStatus)) {
            throw new AuraHandledException('Invalid input provided.');
        }

        Job_Application__c app = [
            SELECT Id, Status__c
            FROM Job_Application__c
            WHERE Id = :recordId
            LIMIT 1
        ];

        app.Status__c = newStatus;

        update app;
    }
}