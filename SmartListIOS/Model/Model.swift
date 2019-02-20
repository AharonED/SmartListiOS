//
//  Model.swift
//  SmartListIOS
//
//  Created by admin on 24/12/2018.
//  Copyright © 2018 Aharon.Garada. All rights reserved.
//

import Foundation
import UIKit

public class Model<T> where T:BaseModelObject {
    
    //static let instance:Model = Model()
 
    var modelSql = ModelSQL<T>();
    var modelFirebase = ModelFirebase<T>();

    public init() {
        
    }
    

    public func getAllRecords(){
        //1. read local students last update date
        let lastUpdated = (modelSql.getLastUpdateDate(database: modelSql.database) as! Double)+1
        //lastUpdated += 1;
        var lastUpdated2 : Double = 0
        
        //2. get updates from firebase and observe
        modelFirebase.getAllRecordsAndObserve(from:lastUpdated){ (data:[T]) in
            print(data.count)
            //3. write new records to the local DB
            for st in data{
                self.modelSql.addNew(database: self.modelSql.database, instance: st)
                if (st.lastUpdate != nil && st.lastUpdate! > lastUpdated){
                    lastUpdated2 = st.lastUpdate!
                }
            }
            
            //4. update the local students last update date
            self.modelSql.setLastUpdateDate(database: self.modelSql.database, date: lastUpdated2)
            
            //5. get the full data
            let stFullData = self.modelSql.getAll(database: self.modelSql.database)
            
            //6. notify observers with full data
            let dummy:BaseModelObject = Groups(_id: "", _name: "", _description: "", _lastUpdate: 0)
            let collectionName = dummy.tableName

            ModelNotification.GetNotification(collectionName: collectionName , dummy: dummy).notify(data: stFullData)
            
            /*
             ModelNotification.GroupsListNotification.notify(data: stFullData as! [Groups])
            */
        }
        
    }
    
    public func addNew(instance: T) throws {
        let fb:ModelFirebase=ModelFirebase<T>()
        try fb.addNew(instance: instance)
        
    }


    func saveImage(image:UIImage, name:(String),callback:@escaping (String?)->Void){
        modelFirebase.saveImage(image: image, name: name, callback: callback)
        
    }
    
    func getImage(url:String, callback:@escaping (UIImage?)->Void){
        //modelFirebase.getImage(url: url, callback: callback)
        
        //1. try to get the image from local store
        let _url = URL(string: url)
        let localImageName = _url!.lastPathComponent
        if let image = self.getImageFromFile(name: localImageName){
            callback(image)
            print("got image from cache \(localImageName)")
        }else{
            //2. get the image from Firebase
            modelFirebase.getImage(url: url){(image:UIImage?) in
                if (image != nil){
                    //3. save the image localy
                    self.saveImageToFile(image: image!, name: localImageName)
                }
                //4. return the image to the user
                callback(image)
                print("got image from firebase \(localImageName)")
            }
        }
    }
    
    
    /// File handling
    func saveImageToFile(image:UIImage, name:String){
        if let data = UIImageJPEGRepresentation(image, 0.8) {
            let filename = getDocumentsDirectory().appendingPathComponent(name)
            try? data.write(to: filename)
        }
    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in:
            .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func getImageFromFile(name:String)->UIImage?{
        let filename = getDocumentsDirectory().appendingPathComponent(name)
        return UIImage(contentsOfFile:filename.path)
    }

    
}
