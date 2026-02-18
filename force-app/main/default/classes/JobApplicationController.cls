public with sharing class JobApplicationController {

    /* ==============================
       GET PAGINATED APPLICATIONS
    ============================== */

    @AuraEnabled(cacheable=true)
    public static List<Job_Application__c> getJobApplications(
        String searchKey,
        String statusFilter,
        Integer pageSize,
        Integer pageNumber
    ) {

        String baseQuery = 
            'SELECT Id, Name, Position__c, Status__c, CreatedDate, Interview_Date__c, Company__r.Name ' +
            'FROM Job_Application__c';

        List<String> conditions = new List<String>();

        if (String.isNotBlank(searchKey)) {
            conditions.add(
                'Name LIKE \'%' + String.escapeSingleQuotes(searchKey) + '%\''
            );
        }

        if (String.isNotBlank(statusFilter) && statusFilter != 'All') {
            conditions.add(
                'Status__c = \'' + String.escapeSingleQuotes(statusFilter) + '\''
            );
        }

        if (!conditions.isEmpty()) {
            baseQuery += ' WHERE ' + String.join(conditions, ' AND ');
        }

        Integer offsetValue = (pageNumber - 1) * pageSize;

        baseQuery += 
            ' ORDER BY CreatedDate DESC ' +
            ' LIMIT :pageSize OFFSET :offsetValue';

        return Database.query(baseQuery);
    }


    /* ==============================
       TOTAL COUNT FOR PAGINATION
    ============================== */

    @AuraEnabled(cacheable=true)
    public static Integer getTotalCount(String searchKey, String statusFilter) {

        String countQuery = 'SELECT COUNT() FROM Job_Application__c';
        List<String> conditions = new List<String>();

        if (String.isNotBlank(searchKey)) {
            conditions.add(
                'Name LIKE \'%' + String.escapeSingleQuotes(searchKey) + '%\''
            );
        }

        if (String.isNotBlank(statusFilter) && statusFilter != 'All') {
            conditions.add(
                'Status__c = \'' + String.escapeSingleQuotes(statusFilter) + '\''
            );
        }

        if (!conditions.isEmpty()) {
            countQuery += ' WHERE ' + String.join(conditions, ' AND ');
        }

        return Database.countQuery(countQuery);
    }


    /* ==============================
       UPDATE STATUS (FORWARD ONLY)
    ============================== */

    @AuraEnabled
    public static void updateStatus(Id recordId, String newStatus) {

        Job_Application__c app = [
            SELECT Id, Status__c
            FROM Job_Application__c
            WHERE Id = :recordId
            LIMIT 1
        ];

        String oldStatus = app.Status__c;

        Map<String, Integer> stageOrder = new Map<String, Integer>{
            'Applied' => 1,
            'Interviewing' => 2,
            'Offered' => 3,
            'Rejected' => 4
        };

        if (!stageOrder.containsKey(oldStatus) || 
            !stageOrder.containsKey(newStatus)) {

            throw new AuraHandledException('Invalid status transition.');
        }

        if (stageOrder.get(newStatus) <= stageOrder.get(oldStatus)) {
            throw new AuraHandledException(
                'You cannot move status backward.'
            );
        }

        app.Status__c = newStatus;
        update app;

        Job_Application_History__c history = 
            new Job_Application_History__c(
                Job_Application__c = app.Id,
                Old_Status__c = oldStatus,
                New_Status__c = newStatus,
                Changed_By__c = UserInfo.getUserId(),
                Changed_On__c = System.now()
            );

        insert history;
    }


    /* ==============================
       DASHBOARD STATS + PERCENTAGES
    ============================== */

    @AuraEnabled(cacheable=true)
    public static Map<String, Integer> getApplicationStats() {

        Map<String, Integer> stats = new Map<String, Integer>();

        Integer total = 
            [SELECT COUNT() FROM Job_Application__c];

        Integer applied = 
            [SELECT COUNT() FROM Job_Application__c 
             WHERE Status__c = 'Applied'];

        Integer interviewing = 
            [SELECT COUNT() FROM Job_Application__c 
             WHERE Status__c = 'Interviewing'];

        Integer offered = 
            [SELECT COUNT() FROM Job_Application__c 
             WHERE Status__c = 'Offered'];

        Integer rejected = 
            [SELECT COUNT() FROM Job_Application__c 
             WHERE Status__c = 'Rejected'];

        stats.put('Total', total);
        stats.put('Applied', applied);
        stats.put('Interviewing', interviewing);
        stats.put('Offered', offered);
        stats.put('Rejected', rejected);

        if (total > 0) {
            stats.put('AppliedPercent', (applied * 100) / total);
            stats.put('InterviewingPercent', (interviewing * 100) / total);
            stats.put('OfferedPercent', (offered * 100) / total);
            stats.put('RejectedPercent', (rejected * 100) / total);
        } else {
            stats.put('AppliedPercent', 0);
            stats.put('InterviewingPercent', 0);
            stats.put('OfferedPercent', 0);
            stats.put('RejectedPercent', 0);
        }

        return stats;
    }
}