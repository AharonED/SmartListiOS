//
//  IModelSQL.swift
//  SmartListIOS
//
//  Created by admin on 05/02/2019.
//  Copyright © 2019 Aharon.Garada. All rights reserved.
//

import Foundation

public protocol IModelSQL{
    func createTable(database: OpaquePointer?)
    func drop(database: OpaquePointer?)
    func getAll(database: OpaquePointer?)->[BaseModelObject]
    func getAllByField(database: OpaquePointer?, fieldName:[String]!, fieldValue:[String]!)->[BaseModelObject]
    func addNew(database: OpaquePointer?, instance:BaseModelObject)
    func get(database: OpaquePointer?, byId:String)->BaseModelObject?
    func getLastUpdateDate(database: OpaquePointer?)->Double
    func setLastUpdateDate(database: OpaquePointer?, date:Double)
}
