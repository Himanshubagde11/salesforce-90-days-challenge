public with sharing class JobApplicationService {

    public static List<Job_Application__c> getApplications(DateTime lastCreatedDate, Integer pageSize) {

        if(pageSize == null || pageSize <= 0){
            pageSize = 10;
        }

        String baseQuery = 
            'SELECT Id, Name, Position__c, Status__c, Applied_Date__c, Interview_Date__c, Company__r.Name, CreatedDate ' +
            'FROM Job_Application__c ' +
            'WHERE Is_Active__c = true ';

        if(lastCreatedDate != null){
            baseQuery += 'AND CreatedDate < :lastCreatedDate ';
        }

        baseQuery += 'ORDER BY CreatedDate DESC LIMIT :pageSize';

        return Database.query(baseQuery);
    }


    public static void updateStatusEngine(Id recordId, String newStatus){

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

        AppLogger.log('Status updated for record: ' + recordId);
    }
}