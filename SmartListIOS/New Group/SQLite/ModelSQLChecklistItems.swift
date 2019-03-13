//
//  ModelSQLChecklistItems.swift
//  SmartListIOS
//
//  Created by admin on 11/03/2019.
//  Copyright © 2019 Aharon.Garada. All rights reserved.
//

import Foundation

public class ModelSQLChecklistItems:IModelSQL {

    public var database: OpaquePointer? = ModelSQLDatabase.getInstance()
    public let tableName:String = "ChecklistItems"
    
    init() {
        
    }
   
    
    public func createTable(database: OpaquePointer?)  {
        var errormsg: UnsafeMutablePointer<Int8>? = nil
        let res = sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS CHECKLISTITEMS (ID TEXT PRIMARY KEY, NAME TEXT, DESCRIPTION TEXT, ATTRIBUTES TEXT, CHECKLISTID TEXT, OWNER TEXT, ITEMTYPE TEXT)", nil, nil, &errormsg);
        if(res != 0){
            print("error creating table");
            return
        }
    }
    
    public func drop(database: OpaquePointer?)  {
        var errormsg: UnsafeMutablePointer<Int8>? = nil
        let res = sqlite3_exec(database, "DROP TABLE CHECKLISTITEMS;", nil, nil, &errormsg);
        if(res != 0){
            print("error creating table");
            return
        }
    }
    
    public func getAll(database: OpaquePointer?)->[BaseModelObject]{
        var sqlite3_stmt: OpaquePointer? = nil
        var data = [BaseModelObject]()
        if (sqlite3_prepare_v2(database,"SELECT * from CHECKLISTITEMS;",-1,&sqlite3_stmt,nil)
            == SQLITE_OK){
            while(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                let stId = String(cString:sqlite3_column_text(sqlite3_stmt,0)!)
                let name = String(cString:sqlite3_column_text(sqlite3_stmt,1)!)
                let description = String(cString:sqlite3_column_text(sqlite3_stmt,2)!)
                let attributes = String(cString:sqlite3_column_text(sqlite3_stmt,3)!)
                let checklistId = String(cString:sqlite3_column_text(sqlite3_stmt,4)!)
                let owner = String(cString:sqlite3_column_text(sqlite3_stmt,5)!)
                let itemType = String(cString:sqlite3_column_text(sqlite3_stmt,6)!)
                
                var json = [String:Any]()
                json["id"] = stId
                json["name"] = name
                json["description"] = description
                json["attributes"] = attributes
                json["checklistId"] = checklistId
                json["owner"] = owner
                json["itemType"] = itemType
                
                data.append(ChecklistItems(json:json))
            }
        }
        sqlite3_finalize(sqlite3_stmt)
        return data
    }
    
    public func getAllByField(database: OpaquePointer?, fieldName:[String]!, fieldValue:[String]!)->[BaseModelObject]{
        var sqlite3_stmt: OpaquePointer? = nil
        var data = [BaseModelObject]()
        /*
        var statm = "SELECT * from CHECKLISTITEMS where 1=1 "
        for st in fieldName{
            statm = statm + " AND " + st + " = ? "
        }
        statm = statm + " ORDER BY NAME;"
        
        if (sqlite3_prepare_v2(database,statm,-1,&sqlite3_stmt,nil)
            == SQLITE_OK){
            var indx:Int32=0
            
            for val in fieldValue {
                indx = indx + 1
                sqlite3_bind_text(sqlite3_stmt, indx, val,-1,nil);
            }
            */
        
        var statm = "SELECT * from CHECKLISTITEMS where 1=1 "

        statm = statm + " AND '_' "
        
        for st in fieldName{
            statm = statm + " || " + st + " || '_' "
        }
        
        statm = statm + " = ? "
        
        statm = statm + " ORDER BY NAME;"
        
        if (sqlite3_prepare_v2(database,statm,-1,&sqlite3_stmt,nil)
            == SQLITE_OK){
            
            var statm1:String = "_"
            
            for val in fieldValue {
                statm1 = statm1 + val + "_"
            }
            
            sqlite3_bind_text(sqlite3_stmt, 1, statm1,-1,nil);

            while(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                let stId = String(cString:sqlite3_column_text(sqlite3_stmt,0)!)
                let name = String(cString:sqlite3_column_text(sqlite3_stmt,1)!)
                let description = String(cString:sqlite3_column_text(sqlite3_stmt,2)!)
                let attributes = String(cString:sqlite3_column_text(sqlite3_stmt,3)!)
                let checklistId = String(cString:sqlite3_column_text(sqlite3_stmt,4)!)
                let owner = String(cString:sqlite3_column_text(sqlite3_stmt,5)!)
                let itemType = String(cString:sqlite3_column_text(sqlite3_stmt,6)!)
                
                var json = [String:Any]()
                json["id"] = stId
                json["name"] = name
                json["description"] = description
                json["attributes"] = attributes
                json["checklistId"] = checklistId
                json["owner"] = owner
                json["itemType"] = itemType
                
                data.append(ChecklistItems(json:json))
            }
        }
        sqlite3_finalize(sqlite3_stmt)
        return data
        
    }
    
    public func addNew(database: OpaquePointer?, instance:BaseModelObject){
        let inst:ChecklistItems=instance as! ChecklistItems
        
        var sqlite3_stmt: OpaquePointer? = nil
        if (sqlite3_prepare_v2(database,"INSERT OR REPLACE INTO CHECKLISTITEMS(ID, NAME, DESCRIPTION, ATTRIBUTES, CHECKLISTID, OWNER, ITEMTYPE) VALUES (?,?,?,?,?,?,?);",-1, &sqlite3_stmt,nil) == SQLITE_OK){
            let id = inst.id.cString(using: .utf8)
            let name = inst.name.cString(using: .utf8)
            let description = inst.description.cString(using: .utf8)
            let attributes = inst.attributes.cString(using: .utf8)
            let groupid = inst.checklistId.cString(using: .utf8)
            let owner = inst.owner.cString(using: .utf8)
            let itemType = inst.itemType.cString(using: .utf8)
            
            sqlite3_bind_text(sqlite3_stmt, 1, id,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 2, name,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 3, description,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 4, attributes,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 5, groupid,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 6, owner,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 7, itemType,-1,nil);
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
