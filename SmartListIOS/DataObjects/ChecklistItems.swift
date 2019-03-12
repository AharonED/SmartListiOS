//
//  ChecklistItems.swift
//  SmartListIOS
//
//  Created by admin on 27/02/2019.
//  Copyright © 2019 Aharon.Garada. All rights reserved.
//

import Foundation
import Firebase

public class ChecklistItems : BaseModelObject{
    var name:String
    var description:String
    var attributes:String
    var checklistId:String=""
    var owner:String=""
    var itemType:String=""
    
    
    //var attributes:[Attributes] = [Attributes]()
    
    public convenience init (_id:String, _name:String, _description:String, _checklistId:String, _owner:String, _itemType:String, _attributes:String = "", _lastUpdate:Double?)
    {
        var json = [String:Any]()
        json["id"] = _id
        json["name"] = _name
        json["description"] = _description
        json["checklistId"] = _checklistId
        json["owner"] = _owner
        json["itemType"] = _itemType
        json["attributes"] = _attributes
        json["lastUpdate"] = _lastUpdate
        
        self.init(json:json)
        
    }
    
    
    public required init(json:[String:Any]) {
        name = json["name"] as! String
        description = json["description"] as! String
        
        if json["attributes"] != nil{
            attributes = json["attributes"] as! String
        }else{
            attributes = ""
        }
        
        if json["checklistId"] != nil{
            checklistId = json["checklistId"] as! String
        }
        if json["owner"] != nil{
            owner = json["owner"] as! String
        }
        if json["itemType"] != nil{
            itemType = json["itemType"] as! String
        }
        super.init(json: json)
        super.tableName="ChecklistItems"
    }
    
    override public func toJson() -> [String:Any] {
        var json = [String:Any]()
        json["id"] = id
        json["name"] = name
        json["description"] = description
        json["checklistId"] = checklistId
        json["owner"] = owner
        json["itemType"] = itemType
        
        json["attributes"] = attributes
        json["lastUpdate"] = ServerValue.timestamp()
        return json
    }
}

