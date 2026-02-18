@isTest
public class JobApplicationSchedulerTest {

    @isTest
    static void testScheduler() {

        Test.startTest();
        String jobId = System.schedule(
            'Test Job',
            '0 0 0 1 1 ? 2050',
            new JobApplicationScheduler()
        );
        Test.stopTest();

        CronTrigger ct = [
            SELECT Id, CronExpression, TimesTriggered
            FROM CronTrigger
            WHERE Id = :jobId
        ];

        System.assertEquals(0, ct.TimesTriggered);
    }
}