//
//  BaseModelObject.swift
//  SmartListIOS
//
//  Created by admin on 24/12/2018.
//  Copyright © 2018 Aharon.Garada. All rights reserved.
//

import Foundation

public class BaseModelObject{
    public var id:String
    
    public init(_id:String)
    {
        id=_id
    }
    
    
    public init(json:[String:Any]) {
        id = json["id"] as! String
    }
    
    public func toJson() -> [String:Any] {
        var json = [String:Any]()
        json["id"] = id
        return json
    }
}

