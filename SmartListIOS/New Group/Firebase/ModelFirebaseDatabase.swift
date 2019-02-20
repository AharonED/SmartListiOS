//
//  ModelFirebaseDatabase.swift
//  SmartListIOS
//
//  Created by admin on 01/02/2019.
//  Copyright © 2019 Aharon.Garada. All rights reserved.
//

import Foundation

import Foundation
import Firebase
import FirebaseDatabase

public class ModelFirebaseDatabase {
    
    static var ref: DatabaseReference! = Database.database().reference()
    
    init() {
        //FirebaseApp.configure()
    }
}
