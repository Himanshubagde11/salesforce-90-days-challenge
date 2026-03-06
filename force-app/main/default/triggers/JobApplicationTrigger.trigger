trigger JobApplicationTrigger on Job_Application__c (before update) {

    List<Application_Log__c> logs = new List<Application_Log__c>();

    for(Job_Application__c newApp : Trigger.new){

        Job_Application__c oldApp = Trigger.oldMap.get(newApp.Id);

        if(newApp.Status__c != oldApp.Status__c){

            Application_Log__c log = new Application_Log__c();

            log.Job_Application__c = newApp.Id;
            log.Old_Status__c = oldApp.Status__c;
            log.New_Status__c = newApp.Status__c;

            logs.add(log);
        }
    }

    if(!logs.isEmpty()){
        insert logs;
    }
}