public class JobApplicationCDCHandler {

    public static void handleCDC(
        List<Job_Application__ChangeEvent> events
    ) {

        Set<Id> jobAppIds = new Set<Id>();

        for (Job_Application__ChangeEvent evt : events) {

            // Only react to updates
            if (evt.ChangeEventHeader.getChangeType() == 'UPDATE') {

                // Extract record IDs
                for (Id recId : evt.ChangeEventHeader.getRecordIds()) {
                    jobAppIds.add(recId);
                }
            }
        }

        if (!jobAppIds.isEmpty()) {
            System.enqueueJob(
                new JobApplicationCDCQueueable(jobAppIds)
            );
        }
    }
}