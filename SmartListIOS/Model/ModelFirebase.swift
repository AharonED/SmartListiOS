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

public class ModelFirebase<T> where T:BaseModelObject {
    
    var ref: DatabaseReference!=ModelFirebaseDatabase.ref
    var collectionName:String
    
    init() {
        //FirebaseApp.configure()
        collectionName = String(describing: T.self).components(separatedBy: ".").last!
    }
    
    func getAllRecordsAndObserve(from:Double, callback:@escaping ([T])->Void){
        let stRef = ref.child(collectionName)
        let fbQuery = stRef.queryOrdered(byChild: "lastUpdate").queryStarting(atValue: from)
        fbQuery.observe(.value) { (snapshot) in
            var data = [T]()
            //var elementType: T.Type
            //elementType = T.self
            if let value = snapshot.value as? [String:Any] {
                for (_, json) in value{
                    //let newT = elementType.init(json: json as! [String : Any])
                    data.append(T.init(json: json as! [String : Any]))
                }
            }
            callback(data)
        }
    }
    
    public func addNew(instance: T) throws {
        //let collectionName:String=String(describing: instance).components(separatedBy: ".").last!
        
        //do {
            //try
                //ref.child(collectionName).child(instance.id).setValue(instance.toJson())
        //} catch {
        //    print("Unexpected error: \(error).")
        //}

        do {
            try
                self.ref.child(collectionName).child(instance.id).setValue(instance.toJson()) {
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
