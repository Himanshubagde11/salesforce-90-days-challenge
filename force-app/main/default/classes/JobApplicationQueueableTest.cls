@isTest
public class JobApplicationQueueableTest {

    @isTest
    static void testQueueableJob() {

        Job_Application__c app = new Job_Application__c(
            Name = 'Queueable Test',
            Status__c = 'Applied',
            Interview_Date__c = Date.today().addDays(1),
            Position__c = 'Developer',
            Expected_salary__c = 30000
        );
        insert app;

        Set<Id> ids = new Set<Id>{ app.Id };

        Test.startTest();
        System.enqueueJob(new JobApplicationQueueable(ids));
        Test.stopTest();

        Job_Application__c updatedApp = [
            SELECT Status__c
            FROM Job_Application__c
            WHERE Id = :app.Id
        ];

        System.assertEquals(
            'Interviewing',
            updatedApp.Status__c,
            'Queueable job should update status'
        );
    }
}