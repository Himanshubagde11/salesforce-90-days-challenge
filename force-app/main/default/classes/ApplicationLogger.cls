public class ApplicationLogger {

    public static void log(String message, String status, Id recordId){

        Application_Log__c log = new Application_Log__c();

        log.Message__c = message;
        log.Status__c = status;
        log.Job_Application__c = recordId;
        log.Log_Time__c = System.now();

        insert log;
    }
}