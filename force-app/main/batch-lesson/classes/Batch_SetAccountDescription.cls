/**
 * Created by user on 03.09.2019.
 */

public with sharing class Batch_SetAccountDescription implements Database.Batchable<SObject> {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id, Name, Description, BillingStreet, BillingCity, BillingState, BillingCountry
        FROM Account]);
    }

    public void execute(Database.BatchableContext bc, List<Account> scope) {
        List<Account> accountsToUpdate = new List<Account>();
        for (Account account : scope){
        account.Description = account.Name;
        if(account.BillingStreet != null) account.Description += ' ' + account.BillingStreet;
        if(account.BillingCity != null) account.Description += ' ' + account.BillingCity;
        if(account.BillingState != null) account.Description += ' ' + account.BillingState;
        if(account.BillingCountry != null) account.Description += ' ' + account.BillingCountry;

        System.debug('>>> Account ' + account.Name + 'processed');
    }
    update scope;
    }

    public void finish(Database.BatchableContext bc){
    }

    public static void run(){
        Database.executeBatch(new Batch_SetAccountDescription());
    }
}