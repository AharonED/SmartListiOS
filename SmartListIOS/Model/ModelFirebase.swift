//
//  ModelFirebase.swift
//  SmartListIOS
//
//  Created by admin on 25/12/2018.
//  Copyright © 2018 Aharon.Garada. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

public class ModelFirebase:IModel {
    
    var ref: DatabaseReference!
    
    init() {
        //FirebaseApp.configure()
        ref = Database.database().reference()
    }
    
    public func addNew(instance: BaseModelObject) {
        let collectionName:String=String(describing: instance).components(separatedBy: ".").last!
        
        //do {
            //try
                //ref.child(collectionName).child(instance.id).setValue(instance.toJson())
        //} catch {
        //    print("Unexpected error: \(error).")
        //}
                ref.child(collectionName).child(instance.id).setValue(instance.toJson()) {
                    (error:Error?, ref:DatabaseReference) in
                    if let error = error {
                        print("Data could not be saved: \(error).")
                    } else {
                        print("Data saved successfully!")
                    }
        }
        
    }
    
}
