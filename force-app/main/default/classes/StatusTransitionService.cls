public with sharing class StatusTransitionService {

    public static void validateTransition(String fromStatus, String toStatus) {

        String currentProfile = [
            SELECT Profile.Name
            FROM User
            WHERE Id = :UserInfo.getUserId()
        ].Profile.Name;

        List<Status_Transition_Rule__mdt> rules = [
            SELECT From_Status__c, To_Status__c, Allowed_Profile__c
            FROM Status_Transition_Rule__mdt
            WHERE From_Status__c = :fromStatus
            AND To_Status__c = :toStatus
        ];

        if (rules.isEmpty()) {
            throw new AuraHandledException('Invalid status transition.');
        }

        Boolean authorized = false;

        for (Status_Transition_Rule__mdt rule : rules) {
            if (rule.Allowed_Profile__c == currentProfile) {
                authorized = true;
                break;
            }
        }

        if (!authorized) {
            throw new AuraHandledException(
                'You are not authorized to perform this transition.'
            );
        }
    }
}