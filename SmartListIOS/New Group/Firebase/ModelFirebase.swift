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
    
    var ref: DatabaseReference! = ModelFirebaseDatabase.ref
    var collectionName:String
    
    init() {
        //FirebaseApp.configure()
        self.collectionName = String(describing: T.self).components(separatedBy: ".").last!
    }
    
    func getAllRecordsAndObserve(from:Double, callback:@escaping ([T])->Void){
        let stRef = self.ref.child(self.collectionName)
        let fbQuery = stRef.queryOrdered(byChild: "lastUpdate").queryStarting(atValue: from)
        
        fbQuery.observe(.value) { (snapshot) in
            print("fbQuery.observe")
            
            var data = [T]()
//            if let value = snapshot.value as? [String:Any] {
            if let value = self.convertSnapshot2Json(snapshot: snapshot) as? [String:Any]  {
                for (_, json) in value{
                    //let newT = elementType.init(json: json as! [String : Any])
                    data.append(T.init(json: json as! [String : Any]))
                }
            }
            callback(data)
        }
        
        /*
        self.ref.child(self.collectionName).observe(.value, with: {
            (snapshot) in
            // Get user value
            var data = [T]()
            
            let value = self.convertSnapshot2Json(snapshot: snapshot)
            
            /*
            let value = snapshot.value as! [NSArray]
        
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? DataSnapshot {
                //this is 1 single message here
                let values = rest.value as? NSDictionary
                var json = [String:Any]()
                for (key, value) in values!{
                    print("Key: \(key), value: \(value)")
                    json["\(key)"] = value
                }
                data.append(T.init(json:json))
                
               // let textUser = values?["id"] as? String ?? "";
            }
            */
             for (_, json) in value{
                data.append(T.init(json: json as! [String : Any]))
            }
            callback(data)
        })
        */
    }
    
    public func convertSnapshot2Json(snapshot:DataSnapshot)->[String:Any]
    {
       
        var jsonArry:[String:Any] = [String:Any]()
        var i:Int32=0
        let enumerator = snapshot.children
        while let rest = enumerator.nextObject() as? DataSnapshot {
            //this is 1 single message here
            let values = rest.value as? NSDictionary
            var json = [String:Any]()
            for (key, value) in values!{
                print("Key: \(key), value: \(value)")
                json["\(key)"] = value
            }
            i=i+1
            
            jsonArry[String(i)] = json
            
            // let textUser = values?["id"] as? String ?? "";
        }
        return jsonArry
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
    
    lazy var storageRef = Storage.storage().reference(forURL:
        "gs://smartlistios-7a38f.appspot.com")
    
    public func saveImage(image:UIImage, name:(String),
                   callback:@escaping (String?)->Void){
        let data = UIImageJPEGRepresentation(image,0.8)
        let imageRef = storageRef.child(name)
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        imageRef.putData(data!, metadata: metadata) { (metadata, error) in
            imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    return
                }
                print("url: \(downloadURL)")
                callback(downloadURL.absoluteString)
            }
        }
    }
    
    public func getImage(url:String, callback:@escaping (UIImage?)->Void){
        let ref = Storage.storage().reference(forURL: url)
        ref.getData(maxSize: 10 * 1024 * 1024) { data, error in
            if error != nil {
                callback(nil)
            } else {
                let image = UIImage(data: data!)
                callback(image)
            }
        }
    }
    
    
}
