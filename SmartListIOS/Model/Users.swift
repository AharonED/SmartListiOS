//
//  Users.swift
//  SmartListIOS
//
//  Created by admin on 24/12/2018.
//  Copyright © 2018 Aharon.Garada. All rights reserved.
//

import Foundation

public class Users:BaseModelObject{
    var name:String
    var email:String
    var password:String
    
    init(_id:String, _name:String, _email:String, _password:String)
    {
        super.init(_id)
        name=_name
        email=_email
        password=_password
        
    }
    
    
    override init(json:[String:Any]) {
        if json["id"] == nil{
            fatalError("Missing id!");
        }
        
        id = json["id"] as! String
        email = json["email"] as! String
        password = json["password"] as! String
        if json["name"] != nil{
            name = json["name"] as! String
        }else{
            name = ""
        }
    }
    
    override func toJson() -> [String:Any] {
        var json = [String:Any]()
        json["id"] = id
        json["email"] = email
        json["password"] = password
        json["name"] = name
        return json
    }
}

