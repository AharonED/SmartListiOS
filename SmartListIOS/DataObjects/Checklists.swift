//
//  Checklists.swift
//  SmartListIOS
//
//  Created by admin on 27/02/2019.
//  Copyright © 2019 Aharon.Garada. All rights reserved.
//

import Foundation
import Firebase

public class Checklists : BaseModelObject{
    var name:String
    var description:String
    var url:String
    var groupId:String=""
    var owner:String=""
    var checklistType:String=""
    
    
    var checklistsItems:[ChecklistItems] = [ChecklistItems]()
    
    public convenience init (_id:String, _name:String, _description:String, _groupId:String, _owner:String, _checklistType:String, _url:String = "", _lastUpdate:Double?)
    {
        var json = [String:Any]()
        json["id"] = _id
        json["name"] = _name
        json["description"] = _description
        json["groupId"] = _groupId
        json["owner"] = _owner
        json["checklistType"] = _checklistType
        json["url"] = _url
        json["lastUpdate"] = _lastUpdate
        
        self.init(json:json)
        
    }
    
    
    public required init(json:[String:Any]) {
        name = json["name"] as! String
        description = json["description"] as! String
        
        if json["url"] != nil{
            url = json["url"] as! String
        }else{
            url = ""
        }
        
        if json["groupId"] != nil{
            groupId = json["groupId"] as! String
        }
        if json["owner"] != nil{
            owner = json["owner"] as! String
        }
        if json["checklistType"] != nil{
            checklistType = json["checklistType"] as! String
        }
        super.init(json: json)
        super.tableName="Checklists"
    }
    
    override public func toJson() -> [String:Any] {
        var json = [String:Any]()
        json["id"] = id
        json["name"] = name
        json["description"] = description
        json["groupId"] = groupId
        json["owner"] = owner
        json["checklistType"] = checklistType

        json["url"] = url
        json["lastUpdate"] = ServerValue.timestamp()
        return json
    }
}


