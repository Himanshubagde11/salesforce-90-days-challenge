global class JobApplicationScheduler implements Schedulable {

    global void execute(SchedulableContext sc) {

        System.debug('Scheduler started');

        Database.executeBatch(new JobApplicationBatch(), 200);

    }
}