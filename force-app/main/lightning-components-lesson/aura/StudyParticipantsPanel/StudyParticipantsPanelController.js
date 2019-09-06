/**
 * Created by user on 05.09.2019.
 */

({
  doInit: function(component, event, helper) {
    let action = component.get('c.getInitData');
    action.setCallback(this,function(response) {
      debugger;
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
    component.find('spinner').show();
    let action = component.get('c.search');
    let filter = JSON.stringify(component.get('v.filter'));
    let pagination = JSON.stringify(component.get('v.pagination'));
    let currentTerm = component.get('v.filter.studyTitleTerm');

    action.setParams({
      filter: filter,
      pagination: pagination
    });
    action.setCallback(this, function(response) {
      debugger;
      if(response.getState() === 'SUCCESS') {
        let searchResponse = response.getReturnValue();
        if(component.get('v.filter.studyTitleTerm') === currentTerm){
          component.set('v.pagination', searchResponse.paginationData);
          component.set('v.pageRows', searchResponse.pageRecords);
          component.find('spinner').hide();
        }
      }
    });
    $A.enqueueAction(action);
  }
});