//
//  Users.swift
//  SmartListIOS
//
//  Created by admin on 24/12/2018.
//  Copyright © 2018 Aharon.Garada. All rights reserved.
//

import Foundation

public class Users : BaseModelObject{
    var firstName:String
    var lastName:String
    var email:String
    var password:String
    
    init(_id:String, _firstName:String, _lastName:String, _email:String, _password:String)
    {
        firstName = _firstName
        lastName = _lastName
        email=_email
        password=_password
        super.init(_id: _id)
    }
    
    
    override init(json:[String:Any]) {
        
        if json["id"] == nil{
            fatalError("Missing id!");
        }
        let id = json["id"] as! String

        email = json["email"] as! String
        password = json["password"] as! String
        if json["firstName"] != nil{
            firstName = json["firstName"] as! String
        }else{
            firstName = ""
        }
        if json["lastName"] != nil{
            lastName = json["lastName"] as! String
        }else{
            lastName = ""
        }
        
        super.init(_id: id)
        
    }
    
    override public func toJson() -> [String:Any] {
        var json = [String:Any]()
        json["id"] = id
        json["email"] = email
        json["password"] = password
        json["firstName"] = firstName
        json["lastName"] = lastName
        return json
    }
}

