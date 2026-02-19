public with sharing class StatusTransitionService {

    @AuraEnabled(cacheable=true)
    public static List<String> getAllowedNextStatuses(String currentStatus) {

        List<String> allowedStatuses = new List<String>();

        List<Status_Transition_Rule__mdt> rules = [
            SELECT To_Status__c, Is_Allowed__c
            FROM Status_Transition_Rule__mdt
            WHERE From_Status__c = :currentStatus
            AND Is_Allowed__c = true
        ];

        for(Status_Transition_Rule__mdt rule : rules) {
            allowedStatuses.add(rule.To_Status__c);
        }

        return allowedStatuses;
    }

    public static void validateTransition(String oldStatus, String newStatus) {

        if(oldStatus == newStatus) {
            return;
        }

        List<Status_Transition_Rule__mdt> rules = [
            SELECT Is_Allowed__c
            FROM Status_Transition_Rule__mdt
            WHERE From_Status__c = :oldStatus
            AND To_Status__c = :newStatus
        ];

        if(rules.isEmpty()) {
            throw new AuraHandledException('Invalid transition');
        }

        if(!rules[0].Is_Allowed__c) {
            throw new AuraHandledException('Transition not allowed');
        }
    }
}