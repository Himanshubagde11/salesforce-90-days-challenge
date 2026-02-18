@isTest
public class JobApplicationBatchTest {

    @isTest
    static void testBatchExecution() {

        Job_Application__c app = new Job_Application__c(
            Name = 'Batch Test',
            Status__c = 'Applied',
            Interview_Date__c = Date.today().addDays(1),
            Position__c = 'Developer',
            Expected_salary__c = 30000
        );
        insert app;

        Test.startTest();

        Database.executeBatch(new JobApplicationBatch(), 1);

        Test.stopTest();

        Job_Application__c updatedApp = [
            SELECT Status__c
            FROM Job_Application__c
            WHERE Id = :app.Id
        ];

        System.assertEquals(
            'Interviewing',
            updatedApp.Status__c,
            'Batch should update status'
        );
    }
}