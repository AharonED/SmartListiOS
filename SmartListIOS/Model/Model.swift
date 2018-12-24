//
//  Model.swift
//  SmartListIOS
//
//  Created by admin on 24/12/2018.
//  Copyright © 2018 Aharon.Garada. All rights reserved.
//

import Foundation

public class Model:IModel {
    
    var modelFirebase:ModelFirebase?
    
    init(){
        modelFirebase = ModelFirebase()
        
    }
    public func addNew(instance: BaseModelObject) {
        modelFirebase?.addNew(instance: instance)
    }
    
    
}
