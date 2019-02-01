//
//  Groups.swift
//  SmartListIOS
//
//  Created by admin on 25/12/2018.
//  Copyright © 2018 Aharon.Garada. All rights reserved.
//

import Foundation
import Firebase

public class Groups : BaseModelObject{
    var name:String
    var description:String
    var url:String
 
    var users:[GroupUsers] = [GroupUsers]()
     
/*
     "groups": {
        "1": {  //Group ID = 1
            "name": "Group1",
            "description": "Group 1 is th first",
            "url": "Group1.jpeg",
            "users": {
                "Dany": true,
                "Max": true,
                "Robert": true
                }
            },
            ...
     }
 */
    
    
    init(_id:String, _name:String, _description:String, _url:String = "", _lastUpdate:Double?)
    {
        name = _name
        description = _description
        url = _url
        super.init(_id: _id)
        super.lastUpdate = _lastUpdate
   }
    
    
    public required init(json:[String:Any]) {
        
        if json["id"] == nil{
            fatalError("Missing id!");
        }
        let id = json["id"] as! String

        name = json["name"] as! String
        description = json["description"] as! String
        //url = json["url"] as! String
        //lastUpdate = json["lastUpdate"] as! Double?
        
        if json["url"] != nil{
            url = json["url"] as! String
        }else{
            url = ""
        }

        super.init(_id: id)
        if json["lastUpdate"] != nil {
            if let lud = json["lastUpdate"] as? Double{
                super.lastUpdate = lud
            }
        }

        
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


