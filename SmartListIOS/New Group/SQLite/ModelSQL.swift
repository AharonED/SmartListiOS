//
//  ModelSQL.swift
//  SmartListIOS
//
//  Created by admin on 01/02/2019.
//  Copyright © 2019 Aharon.Garada. All rights reserved.
//

import Foundation
//import Firebase
//import FirebaseDatabase

public class ModelSQL<T> where T: BaseModelObject {
    public var database: OpaquePointer? = ModelSQLDatabase.getInstance()
    var collectionName:String
    var model:IModelSQL
    
    init() {
        collectionName = String(describing: T.self).components(separatedBy: ".").last!
        model = ModelSQLFactory<Groups>.GetModelSQLInstance()
    }
    
    public func createTable(database: OpaquePointer?)  {
        model.createTable(database: database)
    }
    
    public func drop(database: OpaquePointer?)  {
        model.drop(database: database)
    }
    
    public func getAll(database: OpaquePointer?)->[T]{
        return model.getAll(database: database) as! [T]
    }
    
    public func addNew(database: OpaquePointer?, instance:T){
        model.addNew(database: database, instance: instance)
    }
    
    public func get(database: OpaquePointer?, byId:String)->T?{
        return (model.get(database: database,byId: byId) as! T);
    }
    
    public func getLastUpdateDate(database: OpaquePointer?)->Double{
        return model.getLastUpdateDate(database: database)
    }
    
    public func setLastUpdateDate(database: OpaquePointer?, date:Double){
        model.setLastUpdateDate(database: database, date: date)
        
    }
}
