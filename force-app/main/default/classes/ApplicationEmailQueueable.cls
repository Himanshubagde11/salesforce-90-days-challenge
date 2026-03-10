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
            SELECT Id, Name, Status__c, Owner.Email
            FROM Job_Application__c
            WHERE Id = :applicationId
            LIMIT 1
        ];

        System.debug('Application Found: ' + app.Name);

        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();

        email.setToAddresses(new String[] { app.Owner.Email });

        email.setSaveAsActivity(false);

        if(status == 'Interviewing'){
            System.debug('Using Interview Template');
            email.setSubject('Interview Invitation');
            email.setPlainTextBody('Your application has moved to the Interview stage.');
        }
        else if(status == 'Offered'){
            System.debug('Using Offer Template');
            email.setSubject('Job Offer');
            email.setPlainTextBody('Congratulations! You have received a job offer.');
        }
        else if(status == 'Rejected'){
            System.debug('Using Rejection Template');
            email.setSubject('Application Update');
            email.setPlainTextBody('Thank you for applying. Unfortunately you were not selected.');
        }

        System.debug('Sending Email...');

        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});

        System.debug('EMAIL SENT SUCCESSFULLY');
    }
}