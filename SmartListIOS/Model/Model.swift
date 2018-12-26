//
//  Model.swift
//  SmartListIOS
//
//  Created by admin on 24/12/2018.
//  Copyright © 2018 Aharon.Garada. All rights reserved.
//

import Foundation

public class Model:IModel {
    
 
    private init() {
        
    }
    

    public static func addNew(instance: BaseModelObject) throws {
        try ModelFirebase.addNew(instance: instance)
    }
    
    
}
