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


    public static void updateStatusEngine(Id recordId, String newStatus){

        try{

            if (recordId == null || String.isBlank(newStatus)) {
                throw new AuraHandledException('Invalid input provided.');
            }

            Job_Application__c app = [
                SELECT Id, Status__c
                FROM Job_Application__c
                WHERE Id = :recordId
                LIMIT 1
            ];

            String currentStatus = app.Status__c;

            Map<String, Set<String>> allowedTransitions = new Map<String, Set<String>>{
                'Applied' => new Set<String>{'Interviewing','Rejected'},
                'Interviewing' => new Set<String>{'Offered','Rejected'},
                'Offered' => new Set<String>{},
                'Rejected' => new Set<String>{}
            };

            if(!allowedTransitions.containsKey(currentStatus) ||
               !allowedTransitions.get(currentStatus).contains(newStatus)){

                throw new AuraHandledException(
                    'Invalid status transition from ' +
                    currentStatus + ' to ' + newStatus
                );
            }

            app.Status__c = newStatus;

            update app;

        }
        catch(Exception ex){

            ErrorLogger.logError(
                ex,
                'JobApplicationService',
                'updateStatusEngine',
                recordId
            );

            throw new AuraHandledException(ex.getMessage());
        }
    }
}