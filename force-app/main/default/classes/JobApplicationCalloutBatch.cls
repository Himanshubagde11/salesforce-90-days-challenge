global class JobApplicationCalloutBatch 
implements Database.Batchable<sObject>, Database.AllowsCallouts {

    global Database.QueryLocator start(Database.BatchableContext bc) {

        System.debug('START METHOD CALLED');

        return Database.getQueryLocator([
            SELECT Id, Name, Status__c
            FROM Job_Application__c
            WHERE Is_Active__c = true
        ]);
    }

    global void execute(Database.BatchableContext bc, List<sObject> scope) {

        System.debug('EXECUTE RUNNING, size: ' + scope.size());

        Http http = new Http();

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

                System.debug('Response: ' + res.getBody());

            } catch(Exception e){
                System.debug('Callout failed: ' + e.getMessage());
            }
        }
    }

    global void finish(Database.BatchableContext bc){
        System.debug('Callout Batch Finished');
    }
}