/**
 * Created by Dmitry Bobylev on 11.09.2019.
 */

global with sharing class PlatformEventRaise implements
                Database.Batchable<SObject>, Database.RaisesPlatformEvents {
    // class implementation
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator('Select Id ,Name, Amount from Opportunity where Amount >=100000');
    }
    global void execute(Database.BatchableContext BC, List<sObject> scope) {
        List<Opportunity > opps = (List<Opportunity >) scope ;
        List<Cloud_News__e> cnewList = new List<Cloud_News__e>();
        for (Opportunity opp : opps) {
            // Create an instance of the event and store it in the newsEvent
            // variable
            Cloud_News__e newsEvent = new Cloud_News__e(
                    oppId__c = opp.Id,
                    Amount__c = opp.Amount);
            cnewList.add(newsEvent) ;
        }
        EventBus.publish(cnewList);
    }
    global void finish(Database.BatchableContext BC) {
    }
}