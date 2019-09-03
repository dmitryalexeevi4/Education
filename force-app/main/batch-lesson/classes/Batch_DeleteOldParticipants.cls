/**
 * Created by user on 03.09.2019.
 */

public with sharing class Batch_DeleteOldParticipants implements Database.Batchable<SObject>, Database.Stateful{

    private Integer secondsCount;
    private Datetime startProcessing = Datetime.now();

    public Batch_DeleteOldParticipants(Integer secondsCount){
        this.secondsCount = secondsCount;
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id, LastModifiedDate FROM Study_Participant__c  WHERE Status__c ='Closed']);
    }

    public void execute(Database.BatchableContext bc, List<Study_Participant__c> scope){
        List<Study_Participant__c> studyParticipantsToDelete = new List<Study_Participant__c>();
        for(Study_Participant__c studyParticipant : scope){
            Long delta = (startProcessing.getTime() - studyParticipant.LastModifiedDate.getTime()) / 1000;
            if (delta > secondsCount) studyParticipantsToDelete.add(studyParticipant);
        }

        delete scope;
    }

    public void finish(Database.BatchableContext bc){
    }

    public static void run(Integer secondsCount){
        Database.executeBatch(new Batch_DeleteOldParticipants(secondsCount), 1);
    }
}