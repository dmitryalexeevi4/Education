/**
 * Created by user on 02.09.2019.
 */

public with sharing class StudyParticipantTriggerHandler {

    public static void updateStudyParticipantKey(List <Study_Participant__c> spList){

        Set<Id> clinicalStudyIds = new Set<Id>();

        for (Study_Participant__c sp : spList) clinicalStudyIds.add(sp.Clinical_Study__c);


        List<Clinical_Study__c> clinicalStudies = [
                SELECT Id, Name
                FROM Clinical_Study__c
                WHERE Id IN : clinicalStudyIds
        ];

        //var1
        Map<Id, Clinical_Study__c> clinicalStudyMap = new Map<Id, Clinical_Study__c>();
        for (Clinical_Study__c clinicalStudy : clinicalStudies) clinicalStudyMap.put(clinicalStudy.Id, clinicalStudy);

        //var2
        //clinicalStudyMap = new Map<Id, Clinical_Study__c>(clinicalStudies);

        for (Study_Participant__c sp : spList) {
            String studyName = clinicalStudyMap.get(sp.Clinical_Study__c).Name;
            sp.Study_Participant_Key__c = sp.Contact__c + ' ' + studyName;
        }
    }
}