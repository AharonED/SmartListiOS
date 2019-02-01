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
        super.init(_id: _id)
    }
     
    
    public required init(json:[String:Any]) {
        
        if json["id"] == nil{
            fatalError("Missing id!");
        }
        let id = json["id"] as! String
        
        groupId = json["groupId"] as! String
        userId = json["userId"] as! String
        super.init(_id: id)
        
    }
    
    override public func toJson() -> [String:Any] {
        var json = [String:Any]()
        json["id"] = id
        json["groupId"] = groupId
        json["userId"] = userId
        return json
    }
}


