//
//  DataObjectFactory.swift
//  SmartListIOS
//
//  Created by admin on 09/03/2019.
//  Copyright © 2019 Aharon.Garada. All rights reserved.
//

import Foundation
public class DataObjectFactory {
    init(type: String) {
        
    }
    
    static func GetInstance(type: String)->BaseModelObject {
        var obj:BaseModelObject
        switch type {
        case "Groups":
            obj=Groups(_id: "", _name: "", _description: "", _owner: (LoggedUser.user?.id)!, _privacyType:"" , _lastUpdate: 0)
            break
        case "Checklists":
            obj=Checklists(_id: "", _name: "", _description: "", _groupId:"", _owner:"", _checklistType:"", _url: "",_lastUpdate: 0)
        default:
            obj=Groups(_id: "", _name: "", _description: "", _owner: (LoggedUser.user?.id)!, _privacyType:"" , _lastUpdate: 0)
            break
        }
        return obj
    }
    
}
