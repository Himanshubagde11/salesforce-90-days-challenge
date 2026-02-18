public class JobApplicationSchedulerV2 implements Schedulable {

    public void execute(SchedulableContext sc) {

        // Call batch or queueable
        JobApplicationBatch batchJob = new JobApplicationBatch();
        Database.executeBatch(batchJob, 50);
    }
}