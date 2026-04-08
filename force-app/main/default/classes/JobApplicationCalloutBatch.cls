global class JobApplicationCalloutBatch 
implements Database.Batchable<sObject>, Database.AllowsCallouts {

    global Database.QueryLocator start(Database.BatchableContext bc) {

        return Database.getQueryLocator([
            SELECT Id, Name, Status__c, Callout_Status__c, Retry_Count__c
            FROM Job_Application__c
            WHERE Is_Active__c = true
            AND (
                Callout_Status__c = null 
                OR Callout_Status__c = 'Failed'
            )
            AND (
                Retry_Count__c = null 
                OR Retry_Count__c < 3
            )
        ]);
    }

    global void execute(Database.BatchableContext bc, List<sObject> scope) {

        Http http = new Http();
        List<Job_Application__c> updates = new List<Job_Application__c>();

        for(sObject obj : scope){

            Job_Application__c app = (Job_Application__c) obj;

            try{
                HttpRequest req = new HttpRequest();
                req.setEndpoint('https://jsonplaceholder.typicode.com/posts');
                req.setMethod('POST');
                req.setHeader('Content-Type', 'application/json');

                String body = JSON.serialize(new Map<String, Object>{
                    'name' => app.Name,
                    'status' => app.Status__c
                });

                req.setBody(body);

                HttpResponse res = http.send(req);

                if(res.getStatusCode() == 200 || res.getStatusCode() == 201){

                    app.Callout_Status__c = 'Success';
                    app.API_Response__c = res.getBody();
                    app.Retry_Count__c = 0;

                    ApplicationLogger.log(
                        'Callout successful. StatusCode: ' + res.getStatusCode() + 
                        ' Response: ' + res.getBody(),
                        'Success',
                        app.Id
                    );

                } else {

                    throw new CalloutException(
                        'API failed with status: ' + res.getStatusCode()
                    );
                }

            } catch(Exception e){

                app.Callout_Status__c = 'Failed';
                app.API_Response__c = e.getMessage();

                if(app.Retry_Count__c == null){
                    app.Retry_Count__c = 1;
                } else {
                    app.Retry_Count__c += 1;
                }

                ApplicationLogger.log(
                    'Callout failed. Error: ' + e.getMessage(),
                    'Failed',
                    app.Id
                );
            }

            updates.add(app);
        }

        if(!updates.isEmpty()){
            update updates;
        }
    }

    global void finish(Database.BatchableContext bc){
        System.debug('Callout Batch Finished');
    }
}