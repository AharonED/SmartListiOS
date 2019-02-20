//
//  GroupUsers.swift
//  SmartListIOS
//
//  Created by admin on 26/12/2018.
//  Copyright © 2018 Aharon.Garada. All rights reserved.
//

import Foundation

public class GroupUsers : BaseModelObject{
    var groupId:String
    var userId:String
    
    init(_id:String, _groupId:String, _userId:String)
    {
        groupId = _groupId
        userId = _userId
        
        var json = [String:Any]()
        json["id"] = _id
        
        super.init(json: json)
    }
     
    
    public required init(json:[String:Any]) {
        
        groupId = json["groupId"] as! String
        userId = json["userId"] as! String
        
            
        super.init(json: json)
        
    }
    
    override public func toJson() -> [String:Any] {
        var json = [String:Any]()
        json["id"] = id
        json["groupId"] = groupId
        json["userId"] = userId
        return json
    }
}


