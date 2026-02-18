global class JobApplicationScheduler implements Schedulable {

    global void execute(SchedulableContext sc) {
        Database.executeBatch(new JobApplicationBatch(), 1);
    }
}