public with sharing class JobApplicationTriggerHandler {

    public static void beforeUpdate(
        List<Job_Application__c> newList,
        Map<Id, Job_Application__c> oldMap
    ){

        System.debug('=== TRIGGER HANDLER STARTED ===');

        List<Application_Log__c> logs = new List<Application_Log__c>();

        for(Job_Application__c newApp : newList){

            Job_Application__c oldApp = oldMap.get(newApp.Id);

            System.debug('Old Status: ' + oldApp.Status__c);
            System.debug('New Status: ' + newApp.Status__c);

            if(newApp.Status__c != oldApp.Status__c){

                System.debug('STATUS CHANGED - CREATING LOG');

                Application_Log__c logRecord = new Application_Log__c();

                logRecord.Job_Application__c = newApp.Id;
                logRecord.Old_Status__c = oldApp.Status__c;
                logRecord.New_Status__c = newApp.Status__c;

                logs.add(logRecord);
            }
        }

        System.debug('LOG SIZE: ' + logs.size());

        if(!logs.isEmpty()){
            insert logs;
        }

        System.debug('=== TRIGGER HANDLER FINISHED ===');
    }
}