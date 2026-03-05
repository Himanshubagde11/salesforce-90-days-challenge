trigger JobApplicationCDCTrigger
on Job_Application__ChangeEvent (after insert) {

    for (Job_Application__ChangeEvent evt : Trigger.new) {

        // Always access header first
        EventBus.ChangeEventHeader header = evt.ChangeEventHeader;

        // Get record Ids safely
        List<Id> recordIds = header.getRecordIds();

        System.debug('CDC EVENT FIRED');
        System.debug('Change Type: ' + header.getChangeType());
        System.debug('Record Ids: ' + recordIds);
        System.debug('Changed Fields: ' + header.getChangedFields());
    }
}