/**
 * Created by Dmitry Bobylev on 11.09.2019.
 */

public with sharing class PushTopicController {
        public PushTopicController() {
        }
        public List<Opportunity> getlistOpportunity() {
            return [SELECT Id, Name,StageName FROM Opportunity where Amount>=100000];
        }
        public PageReference refresh() {
            getlistOpportunity();
            return null;
        }
}