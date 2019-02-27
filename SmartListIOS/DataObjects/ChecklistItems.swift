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
    var url:String
    
    var checklistsItems:[ChecklistItems] = [ChecklistItems]()
      
    public convenience init (_id:String, _name:String, _description:String, _url:String = "", _lastUpdate:Double?)
    {
        var json = [String:Any]()
        json["id"] = _id
        json["name"] = _name
        json["description"] = _description
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
        super.init(json: json)
        super.tableName="ChecklistItems"
    }
    
    override public func toJson() -> [String:Any] {
        var json = [String:Any]()
        json["id"] = id
        json["name"] = name
        json["description"] = description
        
        json["url"] = url
        json["lastUpdate"] = ServerValue.timestamp()
        return json
    }
}


