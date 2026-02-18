@isTest
public class JobApplicationQueueableChainTest {

    @isTest
    static void testQueueableChaining() {

        Job_Application__c app = new Job_Application__c(
            Name = 'Queue Test',
            Status__c = 'Applied',
            Interview_Date__c = Date.today().addDays(1),
            Position__c = 'Developer',
            Expected_salary__c = 30000,
            Queue_Processed__c = false
        );
        insert app;

        Test.startTest();
        System.enqueueJob(
            new JobApplicationQueueable(new Set<Id>{ app.Id })
        );
        Test.stopTest();

        Job_Application__c updatedApp = [
            SELECT Status__c, Queue_Processed__c
            FROM Job_Application__c
            WHERE Id = :app.Id
        ];

        System.assertEquals('Interviewing', updatedApp.Status__c);
        System.assertEquals(true, updatedApp.Queue_Processed__c);
    }
}