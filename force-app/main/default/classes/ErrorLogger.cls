public with sharing class ErrorLogger {

    public static void logError(
        Exception ex,
        String className,
        String methodName,
        Id recordId
    ){

        Error_Log__c log = new Error_Log__c();

        log.Error_Message__c = ex.getMessage();
        log.Stack_Trace__c = ex.getStackTraceString();
        log.Class_Name__c = className;
        log.Method_Name__c = methodName;

        if(recordId != null){
            log.Related_Record_Id__c = String.valueOf(recordId);
        }

        Database.insert(log,false);
    }
}