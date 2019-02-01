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

public class ModelSQL<T> where T:BaseModelObject {
    public var database: OpaquePointer? = ModelSQLDatabase().database
    var collectionName:String
    
    init() {
        collectionName = String(describing: T.self).components(separatedBy: ".").last!
    }
    
    public func createTable(database: OpaquePointer?)  {
        var errormsg: UnsafeMutablePointer<Int8>? = nil
        let res = sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS STUDENTS (ST_ID TEXT PRIMARY KEY, NAME TEXT, PHONE TEXT)", nil, nil, &errormsg);
        if(res != 0){
            print("error creating table");
            return
        }
    }
    
    public func drop(database: OpaquePointer?)  {
        var errormsg: UnsafeMutablePointer<Int8>? = nil
        let res = sqlite3_exec(database, "DROP TABLE STUDENTS;", nil, nil, &errormsg);
        if(res != 0){
            print("error creating table");
            return
        }
    }
    
    public func getAll(database: OpaquePointer?)->[T]{
        var sqlite3_stmt: OpaquePointer? = nil
        var data = [T]()
        if (sqlite3_prepare_v2(database,"SELECT * from STUDENTS;",-1,&sqlite3_stmt,nil)
            == SQLITE_OK){
            while(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                let stId = String(cString:sqlite3_column_text(sqlite3_stmt,0)!)
                let name = String(cString:sqlite3_column_text(sqlite3_stmt,1)!)
                let phone = String(cString:sqlite3_column_text(sqlite3_stmt,2)!)
//                data.append(T(_id:stId, _name:name,  _phone:phone))
            }
        }
        sqlite3_finalize(sqlite3_stmt)
        return data
    }
    
    public func addNew(database: OpaquePointer?, student:T){
        var sqlite3_stmt: OpaquePointer? = nil
        if (sqlite3_prepare_v2(database,"INSERT OR REPLACE INTO STUDENTS(ST_ID, NAME, PHONE) VALUES (?,?,?);",-1, &sqlite3_stmt,nil) == SQLITE_OK){
            let id = student.id.cString(using: .utf8)
            //let name = student.name.cString(using: .utf8)
            //let phone = student.phone.cString(using: .utf8)
            
            sqlite3_bind_text(sqlite3_stmt, 1, id,-1,nil);
            //sqlite3_bind_text(sqlite3_stmt, 2, name,-1,nil);
            //sqlite3_bind_text(sqlite3_stmt, 3, phone,-1,nil);
            if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                print("new row added succefully")
            }
        }
        sqlite3_finalize(sqlite3_stmt)
    }
    
    public func get(database: OpaquePointer?, byId:String)->T?{
        
        return nil;
    }
    
    public func getLastUpdateDate(database: OpaquePointer?)->Double{
        return LastUpdateDates.get(database: database, tabeName:collectionName )
    }
    
    public func setLastUpdateDate(database: OpaquePointer?, date:Double){
        LastUpdateDates.set(database: database, tabeName: collectionName, date: date);
    }
}
