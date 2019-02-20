//
//  ModelSQLFactory.swift
//  SmartListIOS
//
//  Created by admin on 05/02/2019.
//  Copyright © 2019 Aharon.Garada. All rights reserved.
//

import Foundation
//import Firebase
//import FirebaseDatabase

public class ModelSQLFactory <T> where T: BaseModelObject {
    init(type: String) {
        
    }
    
    static func GetModelSQLInstance()->IModelSQL {
        let collectionName = String(describing: T.self).components(separatedBy: ".").last!
        
        var obj:IModelSQL
        switch collectionName {
        case "Groups":
            obj=ModelSQLGroups()
            break
        default:
             obj=ModelSQLGroups()
            break
        }
        return obj
    }
    
}
