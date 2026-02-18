@isTest
public class JobApplicationErrorHandlingBatchTest {

    @isTest
    static void testBatchUpdatesStatus() {

        Job_Application__c app = new Job_Application__c(
            Name = 'Test Application',
            Status__c = 'Applied'
        );
        insert app;

        Test.startTest();
        Database.executeBatch(new JobApplicationErrorHandlingBatch(), 1);
        Test.stopTest();

        Job_Application__c updatedApp = [
            SELECT Status__c, Interview_Date__c, Position__c
            FROM Job_Application__c
            WHERE Id = :app.Id
        ];

        System.assertEquals('Interviewing', updatedApp.Status__c);
        System.assertNotEquals(null, updatedApp.Interview_Date__c);
        System.assertEquals('Software Engineer', updatedApp.Position__c);
    }
}