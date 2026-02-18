@isTest
public class JobApplicationSchedulerTestV2 {

    @isTest
    static void testSchedulerExecution() {

        Test.startTest();

        String cronExp = '0 0 0 1 1 ? 2099'; // future-safe date

        System.schedule(
            'Test Job Application Scheduler V2',
            cronExp,
            new JobApplicationSchedulerV2()
        );

        Test.stopTest();

        // Verify scheduled job exists
        List<CronTrigger> ct = [
            SELECT Id, CronExpression, State
            FROM CronTrigger
            WHERE CronJobDetail.Name = 'Test Job Application Scheduler V2'
        ];

        System.assertEquals(1, ct.size());
        System.assertEquals('WAITING', ct[0].State);
    }
}