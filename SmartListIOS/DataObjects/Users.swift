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
    
    convenience init(_id:String, _firstName:String, _lastName:String, _email:String, _password:String)
    {
        /*
        firstName = _firstName
        lastName = _lastName
        email=_email
        password=_password
        super.init(_id: _id)
        */
        
        var json = [String:Any]()
        json["id"] = _id
        json["firstName"] = _firstName
        json["lastName"] = _lastName
        json["email"] = _email
        json["password"] = _password
        //json["lastUpdate"] = _lastUpdate
        
        self.init(json:json)
        
    }
    
    
  public required init(json:[String:Any]) {
    

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
    
        super.init(json: json)
        super.tableName="Users"

    }
    
    override public func toJson() -> [String:Any] {
        var json = [String:Any]()
        json["id"] = id
        json["email"] = email
        json["password"] = password
        json["firstName"] = firstName
        json["lastName"] = lastName
//        json["lastUpdate"] = ServerValue.timestamp()
       return json
    }
}

