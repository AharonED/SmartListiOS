//
//  BaseModelObject.swift
//  SmartListIOS
//
//  Created by admin on 24/12/2018.
//  Copyright © 2018 Aharon.Garada. All rights reserved.
//

import Foundation

public class BaseModelObject{
    var id:String
    
    init(_ _id:String)
    {
        id=_id
    }
    
    
    init(json:[String:Any]) {
        id = json["id"] as! String
    }
    
    func toJson() -> [String:Any] {
        var json = [String:Any]()
        json["id"] = id
        return json
    }
}

