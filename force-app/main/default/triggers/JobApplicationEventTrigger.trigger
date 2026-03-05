trigger JobApplicationEventTrigger
on Job_Application_Event__e (after insert) {

    // IMPORTANT: Disable bypass explicitly
    TriggerBypass.skipJobApplicationTrigger = false;

    List<Job_Application__c> appsToUpdate = new List<Job_Application__c>();

    for (Job_Application_Event__e evt : Trigger.new) {

        // Defensive checks
        if (evt.Job_Application_Id__c == null) continue;
        if (evt.Event_Type__c == null) continue;

        if (evt.Event_Type__c == 'MOVE_TO_INTERVIEW') {
            appsToUpdate.add(
                new Job_Application__c(
                    Id = evt.Job_Application_Id__c,
                    Status__c = 'Interviewing'
                )
            );
        }
    }

    if (!appsToUpdate.isEmpty()) {
        update appsToUpdate;
    }
}