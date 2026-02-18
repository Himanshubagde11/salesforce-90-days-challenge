@isTest
public class JobApplicationAsyncServiceTest {

    @isTest
    static void testFutureMethod() {

        // STEP 1: Create test data (MUST satisfy validation rules)
        Job_Application__c app = new Job_Application__c(
            Name = 'Future Test App',
            Status__c = 'Applied',
            Interview_Date__c = Date.today().addDays(1),
            Position__c = 'Software Engineer',
            Expected_salary__c = 30000
        );
        insert app;

        // STEP 2: Prepare IDs (future methods accept primitives only)
        Set<Id> ids = new Set<Id>{ app.Id };

        // STEP 3: Execute future method
        Test.startTest();
        JobApplicationAsyncService.processApplications(ids);
        Test.stopTest();

        // STEP 4: Verify result
        Job_Application__c updatedApp = [
            SELECT Status__c
            FROM Job_Application__c
            WHERE Id = :app.Id
        ];

        System.assertEquals(
            'Interviewing',
            updatedApp.Status__c,
            'Status should be updated by future method'
        );
    }
}