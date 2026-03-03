public with sharing class JobApplicationTriggerHandler {

    public static void handleBeforeUpdate(
        List<Job_Application__c> newRecords,
        Map<Id, Job_Application__c> oldMap
    ){

        for(Job_Application__c record : newRecords){

            Job_Application__c oldRecord = oldMap.get(record.Id);

            if(record.Status__c != oldRecord.Status__c){

                System.debug('Status changed from ' +
                             oldRecord.Status__c +
                             ' to ' +
                             record.Status__c);
            }
        }
    }

    public static void handleAfterUpdate(
        List<Job_Application__c> newRecords,
        Map<Id, Job_Application__c> oldMap
    ){

        List<Application_Log__c> logs = new List<Application_Log__c>();

        for(Job_Application__c record : newRecords){

            Job_Application__c oldRecord = oldMap.get(record.Id);

            if(record.Status__c != oldRecord.Status__c){

                Application_Log__c logRecord = new Application_Log__c();
                logRecord.Job_Application__c = record.Id;
                logRecord.Old_Status__c = oldRecord.Status__c;
                logRecord.New_Status__c = record.Status__c;

                logs.add(logRecord);
            }
        }

        if(!logs.isEmpty()){
            insert logs;
        }
    }
}