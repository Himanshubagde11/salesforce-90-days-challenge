public virtual class BaseTriggerHandler {

    public virtual void beforeInsert(List<SObject> newRecords){}
    public virtual void beforeUpdate(List<SObject> newRecords, Map<Id,SObject> oldMap){}
    public virtual void beforeDelete(Map<Id,SObject> oldMap){}

    public virtual void afterInsert(List<SObject> newRecords){}
    public virtual void afterUpdate(List<SObject> newRecords, Map<Id,SObject> oldMap){}
    public virtual void afterDelete(Map<Id,SObject> oldMap){}
}