//
//  ModelSQLChecklists.swift
//  SmartListIOS
//
//  Created by admin on 09/03/2019.
//  Copyright © 2019 Aharon.Garada. All rights reserved.
//

import Foundation

public class ModelSQLChecklists:IModelSQL {
    public var database: OpaquePointer? = ModelSQLDatabase.getInstance()
    public let tableName:String = "Checklists"

    init() {
        
    }
    
    
    
    
    public func createTable(database: OpaquePointer?)  {
        var errormsg: UnsafeMutablePointer<Int8>? = nil
        let res = sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS CHECKLISTS (ID TEXT PRIMARY KEY, NAME TEXT, DESCRIPTION TEXT, URL TEXT)", nil, nil, &errormsg);
        if(res != 0){
            print("error creating table");
            return
        }
    }
    
    public func drop(database: OpaquePointer?)  {
        var errormsg: UnsafeMutablePointer<Int8>? = nil
        let res = sqlite3_exec(database, "DROP TABLE CHECKLISTS;", nil, nil, &errormsg);
        if(res != 0){
            print("error creating table");
            return
        }
    }
    
    public func getAll(database: OpaquePointer?)->[BaseModelObject]{
        var sqlite3_stmt: OpaquePointer? = nil
        var data = [BaseModelObject]()
        if (sqlite3_prepare_v2(database,"SELECT * from CHECKLISTS;",-1,&sqlite3_stmt,nil)
            == SQLITE_OK){
            while(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                let stId = String(cString:sqlite3_column_text(sqlite3_stmt,0)!)
                let name = String(cString:sqlite3_column_text(sqlite3_stmt,1)!)
                let description = String(cString:sqlite3_column_text(sqlite3_stmt,2)!)
                let url = String(cString:sqlite3_column_text(sqlite3_stmt,3)!)
                
                var json = [String:Any]()
                json["id"] = stId
                json["name"] = name
                json["description"] = description
                json["url"] = url
                
                data.append(Checklists(json:json))
            }
        }
        sqlite3_finalize(sqlite3_stmt)
        return data
    }
    
    public func addNew(database: OpaquePointer?, instance:BaseModelObject){
        let inst:Checklists=instance as! Checklists
        
        var sqlite3_stmt: OpaquePointer? = nil
        if (sqlite3_prepare_v2(database,"INSERT OR REPLACE INTO CHECKLISTS(ID, NAME, DESCRIPTION, URL) VALUES (?,?,?,?);",-1, &sqlite3_stmt,nil) == SQLITE_OK){
            let id = inst.id.cString(using: .utf8)
            let name = inst.name.cString(using: .utf8)
            let description = inst.description.cString(using: .utf8)
            let url = inst.url.cString(using: .utf8)
            
            sqlite3_bind_text(sqlite3_stmt, 1, id,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 2, name,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 3, description,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 4, url,-1,nil);
            if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                print("new row added succefully")
            }
        }
        sqlite3_finalize(sqlite3_stmt)
    }
    
    public func get(database: OpaquePointer?, byId:String)->BaseModelObject?{
        
        return nil;
    }
    
    public func getLastUpdateDate(database: OpaquePointer?)->Double{
        return LastUpdateDates.get(database: database, tabeName:tableName )
    }
    
    public func setLastUpdateDate(database: OpaquePointer?, date:Double){
        LastUpdateDates.set(database: database, tabeName: tableName, date: date);
    }
}
