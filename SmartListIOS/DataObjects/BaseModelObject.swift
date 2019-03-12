//
//  BaseModelObject.swift
//  SmartListIOS
//
//  Created by admin on 24/12/2018.
//  Copyright © 2018 Aharon.Garada. All rights reserved.
//

import Foundation

public class BaseModelObject {
    public var id:String
    public var tableName:String = "BaseModelObject"
    public var UniqueInstanceIdentifier:String = ""

    public var lastUpdate:Double?

    public convenience init(_id:String)
    {
        var json = [String:Any]()
        json["id"] = _id
        self.init(json:json)
    }
    
    
    public required init(json:[String:Any]) {
        if json["id"] == nil{
            fatalError("Missing id!");
        }
        id = json["id"] as! String
        
        if json["lastUpdate"] != nil {
            if let lud = json["lastUpdate"] as? Double{
                self.lastUpdate = lud
            }
        }
    }
    
    public func toJson() -> [String:Any] {
        var json = [String:Any]()
        json["id"] = id
        return json
    }

}

