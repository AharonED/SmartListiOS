//
//  ModelSql.swift
//  SmartListIOS
//
//  Created by admin on 31/01/2019.
//  Copyright © 2019 Aharon.Garada. All rights reserved.
//

import Foundation

public class ModelSQLDatabase {
    public var  database: OpaquePointer? = nil
    
    init() {
        // initialize the DB
        let dbFileName = "database2.db"
        if let dir = FileManager.default.urls(for: .documentDirectory, in:
            .userDomainMask).first{
            let path = dir.appendingPathComponent(dbFileName)
            if sqlite3_open(path.absoluteString, &database) != SQLITE_OK {
                print("Failed to open db file: \(path.absoluteString)")
                return
            }
            //dropTables()
            createTables()
        }
        
    }

  
    func createTables() {
//        Student.createTable(database: database);
//        LastUpdateDates.createTable(database: database);
    }
    
    func dropTables(){
//        Student.drop(database: database)
//        LastUpdateDates.drop(database: database)
    }
    

}
