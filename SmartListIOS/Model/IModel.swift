//
//  IModel.swift
//  SmartListIOS
//
//  Created by admin on 25/12/2018.
//  Copyright © 2018 Aharon.Garada. All rights reserved.
//

import Foundation

public protocol IModel{
    static func addNew(instance:BaseModelObject) throws
    
    static func get(database: OpaquePointer?, byId:String) throws ->BaseModelObject
}
