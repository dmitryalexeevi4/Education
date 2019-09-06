/**
 * Created by user on 05.09.2019.
 */

({
  doInit: function(component, event, helper) {
    let action = component.get('c.getInitData');
    action.setCallback(this,function(response) {
      if(response.getState() === 'SUCCESS') {
        let initData = response.getReturnValue();
        component.set('v.pagination', initData.pagination);
        component.set('v.filter', initData.filter);
        component.set('v.pageRows', initData.pageRows);
        component.set('v.initialized', true);
      }
    });
    $A.enqueueAction(action);
  },

  doSearch: function(component, event, helper) {
    let action = component.get('c.search');
    let filter = JSON.stringify(component.get('v.filter'));
    let pagination = JSON.stringify(component.get('v.pagination'));
    action.setParams({
      filter: filter,
      pagination: pagination
    });
    action.setCallback(this, function(response) {
      debugger;
      if(response.getState() === 'SUCCESS') {
        let searchResponse = response.getReturnValue();
        component.set('v.pagination', searchResponse.pagination);
        component.set('v.pageRows', searchResponse.pageRows);
      }
    });
    $A.enqueueAction(action);
  }
});