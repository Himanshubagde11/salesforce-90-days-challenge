public class JobApplicationNotificationQueueable implements Queueable {

    private Set<Id> applicationIds;

    public JobApplicationNotificationQueueable(Set<Id> ids) {
        this.applicationIds = ids;
    }

    public void execute(QueueableContext context) {
        System.debug('Notification queue executed');
    }
}