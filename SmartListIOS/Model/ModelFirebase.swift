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
    
    static var ref: DatabaseReference!=Database.database().reference()
    
    init() {
        //FirebaseApp.configure()
    }
    
    public static func addNew(instance: BaseModelObject) throws {
        let collectionName:String=String(describing: instance).components(separatedBy: ".").last!
        
        //do {
            //try
                //ref.child(collectionName).child(instance.id).setValue(instance.toJson())
        //} catch {
        //    print("Unexpected error: \(error).")
        //}

        do {
            try
                ref.child(collectionName).child(instance.id).setValue(instance.toJson()) {
                    (error:Error?, ref:DatabaseReference) in
                    if let error = error {
                        print("Data could not be saved: \(error).")
                    } else {
                        print("Data saved successfully!")
                    }
            }
            
        } catch let error {
            print("Unexpected error: \(error).")
            }
    }
}
