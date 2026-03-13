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
            SELECT Id, Name, OwnerId
            FROM Job_Application__c
            WHERE Id = :applicationId
            LIMIT 1
        ];

        Id templateId;

        if(status == 'Interviewing'){
            System.debug('Using Interview Template');

            List<EmailTemplate> templates = [
                SELECT Id
                FROM EmailTemplate
                WHERE DeveloperName = 'Interview_Invitation'
                LIMIT 1
            ];

            if(!templates.isEmpty()){
                templateId = templates[0].Id;
            }
        }

        else if(status == 'Offered'){
            System.debug('Using Offer Template');

            List<EmailTemplate> templates = [
                SELECT Id
                FROM EmailTemplate
                WHERE DeveloperName = 'Job_Offer_Email'
                LIMIT 1
            ];

            if(!templates.isEmpty()){
                templateId = templates[0].Id;
            }
        }

        else if(status == 'Rejected'){
            System.debug('Using Rejection Template');

            List<EmailTemplate> templates = [
                SELECT Id
                FROM EmailTemplate
                WHERE DeveloperName = 'Application_Rejection_Email'
                LIMIT 1
            ];

            if(!templates.isEmpty()){
                templateId = templates[0].Id;
            }
        }

        if(templateId != null){

            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();

            email.setTargetObjectId(app.OwnerId);
            email.setTemplateId(templateId);
            email.setSaveAsActivity(false);

            System.debug('Sending Email...');

            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});

            System.debug('EMAIL SENT SUCCESSFULLY');


            Email_Log__c log = new Email_Log__c();

            log.Job_Application__c = applicationId;

            if(status == 'Interviewing'){
                log.Email_Type__c = 'Interview Invitation';
            }
            else if(status == 'Offered'){
                log.Email_Type__c = 'Job Offer';
            }
            else if(status == 'Rejected'){
                log.Email_Type__c = 'Application Rejection';
            }

            log.Sent_Date__c = System.now();

            insert log;

            System.debug('EMAIL LOG CREATED');

        }
        else{
            System.debug('Template not found!');
        }

    }
}