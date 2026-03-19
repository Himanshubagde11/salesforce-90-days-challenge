global class JobApplicationCalloutBatch 
implements Database.Batchable<sObject>, Database.AllowsCallouts {

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([
            SELECT Id, Name, Status__c
            FROM Job_Application__c
            WHERE Is_Active__c = true
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

                app.API_Response__c = res.getBody();
                app.Callout_Status__c = 'Success';

            } catch(Exception e){
                app.Callout_Status__c = 'Failed';
                app.API_Response__c = e.getMessage();
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