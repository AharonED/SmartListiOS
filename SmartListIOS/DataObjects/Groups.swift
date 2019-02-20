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
    
    
    public convenience init (_id:String, _name:String, _description:String, _url:String = "", _lastUpdate:Double?)
    {
        /*
        name = _name
        description = _description
        url = _url
        super.init(_id: _id)
        super.lastUpdate = _lastUpdate
        */
        
        
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
        super.tableName="Groups"
    }
    
    /*
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    */
    
    
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


