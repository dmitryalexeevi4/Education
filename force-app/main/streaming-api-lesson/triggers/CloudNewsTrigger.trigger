/**
 * Created by Dmitry Bobylev on 11.09.2019.
 */

// Trigger for listening to Cloud_News events.
trigger CloudNewsTrigger on Cloud_News__e (after insert) {
// List to hold all cases to be created.
    List<Case> cases = new List<Case>();
// Get queue Id for case owner
    List<Group> queueL = [
            SELECT Id
            FROM Group
            WHERE DeveloperName = 'Opp_Review_Queue' AND
            Type = 'Queue'
    ];
    if (queueL.isEmpty()) return;
    Group queue = queueL[0];
// Iterate through each notification.
    for (Cloud_News__e event : Trigger.New) {
        if (event.Amount__c >= 100000) {
// Create Case
            Case cs = new Case();
            cs.Priority = 'High';
            cs.Subject = 'The opportunity with high amount, needs your review. OppId=' +
                    event.oppId__c + ', Amount=' + event.Amount__c;
            cs.OwnerId = queue.Id;
            cases.add(cs);
        }
    }
// Insert all cases corresponding to events received.
    insert cases;
}

