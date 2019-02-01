//
//  Model.swift
//  SmartListIOS
//
//  Created by admin on 24/12/2018.
//  Copyright © 2018 Aharon.Garada. All rights reserved.
//

import Foundation

public class Model<T> where T:BaseModelObject {
    
    //static let instance:Model = Model()
 
    var modelSql = ModelSQL<T>();
    var modelFirebase = ModelFirebase<T>();

    public init() {
        
    }
    

    public func getAllRecords(){
        //1. read local students last update date
        var lastUpdated = modelSql.getLastUpdateDate(database: modelSql.database)
        lastUpdated += 1;
        
        //2. get updates from firebase and observe
        modelFirebase.getAllRecordsAndObserve(from:lastUpdated){ (data:[T]) in
            //3. write new records to the local DB
            for st in data{
                self.modelSql.addNew(database: self.modelSql.database, student: st)
                if (st.lastUpdate != nil && st.lastUpdate! > lastUpdated){
                    lastUpdated = st.lastUpdate!
                }
            }
            
            //4. update the local students last update date
            self.modelSql.setLastUpdateDate(database: self.modelSql.database, date: lastUpdated)
            
            //5. get the full data
            let stFullData = self.modelSql.getAll(database: self.modelSql.database)
            
            //6. notify observers with full data
//            ModelNotification.studentsListNotification.notify(data: stFullData)
        }
        
    }
    
    public func addNew(instance: T) throws {
        let fb:ModelFirebase=ModelFirebase<T>()
        try fb.addNew(instance: instance)
        
    }
    
    
}
