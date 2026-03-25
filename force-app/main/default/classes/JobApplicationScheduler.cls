global class JobApplicationScheduler implements Schedulable {

    global void execute(SchedulableContext sc) {

        JobApplicationCalloutBatch batch = new JobApplicationCalloutBatch();

        Database.executeBatch(batch, 5);
    }
}