@isTest
public class JobApplicationStatefulBatchTest {

    @isTest
    static void testStatefulBatch() {

        Job_Application__c app = new Job_Application__c(
            Name = 'Stateful Batch Test',
            Status__c = 'Applied',
            Interview_Date__c = Date.today().addDays(1),
            Position__c = 'Developer',
            Expected_salary__c = 30000
        );
        insert app;

        Test.startTest();
        Database.executeBatch(new JobApplicationStatefulBatch(), 1);
        Test.stopTest();

        Job_Application__c updatedApp = [
            SELECT Status__c
            FROM Job_Application__c
            WHERE Id = :app.Id
        ];

        System.assertEquals(
            'Interviewing',
            updatedApp.Status__c,
            'Status should be updated by stateful batch'
        );
    }
}