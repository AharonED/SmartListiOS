//
//  ModelSql.swift
//  SmartListIOS
//
//  Created by admin on 31/01/2019.
//  Copyright © 2019 Aharon.Garada. All rights reserved.
//

import Foundation

public class ModelSQLDatabase {
    static var  database: OpaquePointer? = nil
    
    static func getInstance()->OpaquePointer? {
        if (database == nil)
        {
        // initialize the DB
        let dbFileName = "smartlist.db"
        if let dir = FileManager.default.urls(for: .documentDirectory, in:
            .userDomainMask).first{
                let path = dir.appendingPathComponent(dbFileName)
            print("db path: \(path) --- \(path.absoluteString)")
                if sqlite3_open(path.absoluteString, &database) != SQLITE_OK {
                    print("Failed to open db file: \(path.absoluteString)")
                    return nil
                }
            
                //dropTables()
                createTables()
                return database;
            }
        }

        return database

    }

  
    static func createTables() {
        ModelSQL<Groups>().createTable(database: self.database);
        ModelSQL<Checklists>().createTable(database: self.database);
        LastUpdateDates.createTable(database: self.database);
    }
    
    static func dropTables(){
        ModelSQL<Groups>().drop(database: self.database);
        ModelSQL<Checklists>().drop(database: self.database);
        LastUpdateDates.drop(database: self.database)
    }
    
}
