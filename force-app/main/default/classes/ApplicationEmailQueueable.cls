public class ApplicationEmailQueueable implements Queueable {

    private Id applicationId;
    private String status;

    public ApplicationEmailQueueable(Id applicationId, String status){
        this.applicationId = applicationId;
        this.status = status;
    }

    public void execute(QueueableContext context){

        System.debug('QUEUEABLE STARTED');
        System.debug('Application Id: ' + applicationId);
        System.debug('Status: ' + status);

        Job_Application__c app = [
            SELECT Id, Name, OwnerId,
                   Interview_Email_Sent__c,
                   Offer_Email_Sent__c,
                   Rejection_Email_Sent__c
            FROM Job_Application__c
            WHERE Id = :applicationId
            LIMIT 1
        ];

        Id templateId;

        if(status == 'Interviewing' && !app.Interview_Email_Sent__c){

            System.debug('Using Interview Template');

            templateId = [
                SELECT Id
                FROM EmailTemplate
                WHERE DeveloperName = 'Interview_Invitation'
                LIMIT 1
            ].Id;

            app.Interview_Email_Sent__c = true;
        }

        else if(status == 'Offered' && !app.Offer_Email_Sent__c){

            System.debug('Using Offer Template');

            templateId = [
                SELECT Id
                FROM EmailTemplate
                WHERE DeveloperName = 'Job_Offer_Email'
                LIMIT 1
            ].Id;

            app.Offer_Email_Sent__c = true;
        }

        else if(status == 'Rejected' && !app.Rejection_Email_Sent__c){

            System.debug('Using Rejection Template');

            templateId = [
                SELECT Id
                FROM EmailTemplate
                WHERE DeveloperName = 'Application_Rejection_Email'
                LIMIT 1
            ].Id;

            app.Rejection_Email_Sent__c = true;
        }

        if(templateId != null){

            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();

            email.setTargetObjectId(app.OwnerId);
            email.setTemplateId(templateId);
            email.setSaveAsActivity(false);

            System.debug('Sending Email...');

            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});

            System.debug('EMAIL SENT SUCCESSFULLY');

            update app;
        }
        else{
            System.debug('Email already sent OR template not found');
        }
    }
}