//
//  Groups.swift
//  SmartListIOS
//
//  Created by admin on 25/12/2018.
//  Copyright © 2018 Aharon.Garada. All rights reserved.
//

import Foundation

public class Groups : BaseModelObject{
    var name:String
    var description:String
    var url:String
    var lastUpdate:Double?

    var users:[GroupUsers] = [GroupUsers]()
     
    
    init(_id:String, _name:String, _description:String, _url:String, _lastUpdate:Double?)
    {
        name = _name
        description = _description
        url = _url
        lastUpdate = _lastUpdate
        super.init(_id: _id)
    }
    
    
    override init(json:[String:Any]) {
        
        if json["id"] == nil{
            fatalError("Missing id!");
        }
        let id = json["id"] as! String
        
        name = json["name"] as! String
        description = json["description"] as! String
        url = json["url"] as! String
        lastUpdate = json["lastUpdate"] as! Double?
        super.init(_id: id)
    }
    
    override public func toJson() -> [String:Any] {
        var json = [String:Any]()
        json["id"] = id
        json["name"] = name
        json["description"] = description
        json["url"] = url
        json["lastUpdate"] = lastUpdate
        return json
    }
}


