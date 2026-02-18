public class JobApplicationEventPublisher {

    public static void publishEvent(Id jobAppId, String eventType) {

        Job_Application_Event__e evt = new Job_Application_Event__e(
            Job_Application_Id__c = jobAppId,
            Event_Type__c = eventType
        );

        Database.SaveResult sr = EventBus.publish(evt);

        if (!sr.isSuccess()) {
            System.debug('Event publish failed');
        }
    }
}