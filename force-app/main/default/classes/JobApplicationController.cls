public with sharing class JobApplicationController {

    @AuraEnabled(cacheable=true)
    public static List<Job_Application__c> getApplications() {
        return JobApplicationService.fetchApplications();
    }

    @AuraEnabled
    public static void updateStatus(Id recordId, String newStatus) {
        JobApplicationService.updateStatusEngine(recordId, newStatus);
    }
}