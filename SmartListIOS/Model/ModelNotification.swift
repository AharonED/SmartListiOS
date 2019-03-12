//
//  ModelNotification.swift
//  SmartListIOS
//
//  Created by admin on 31/01/2019.
//  Copyright © 2019 Aharon.Garada. All rights reserved.
//

import Foundation
import UIKit


class ModelNotification{
    //static let GroupsListNotification = MyNotification<Groups>("Aharon.SmartListIOS")
    //static let UsersListNotification = MyNotification<[Users]>("com.smartlist.users")

    static var ListNotification = [String:Any]()

    static func GetNotification<T>(collectionName:String, dummy:T )->MyNotification<T> where T:BaseModelObject {
       
        let collectionName =  dummy.tableName + dummy.UniqueInstanceIdentifier
        
        var obj:MyNotification<T>
        
       /* switch collectionName {
        case "Groups":
            obj=MyNotification<[T]>("com.smartlist.groups")
            break
        default:
            obj=MyNotification<[T]>("com.smartlist.groups")
            break
        }
         */
        
        if(ListNotification["com.smartlist." + collectionName]==nil)
        {
            obj=MyNotification<T>("com.smartlist." + collectionName)
            ListNotification["com.smartlist." + collectionName]=obj
        }
        else
        {
            obj = ListNotification["com.smartlist." + collectionName] as! MyNotification<T>
        }
        return obj
    }
    
    class MyNotification<T>{
        let name:String
        var count = 0;
        
        init(_ _name:String) {
            name = _name
        }
        
        func observe(cb:@escaping ([T])->Void)-> NSObjectProtocol{
            count += 1
            return NotificationCenter.default.addObserver(forName: NSNotification.Name(name),
                                                          object: nil, queue: nil) { (data) in
                                                            
                                                           // cb(data.userInfo?["data"] as! [T] )
                                                            
                                                            if let data1 = data.userInfo?["data"] as? [T] {
                                                                cb(data1)
                                                            }
            }
        }
        
        func notify(data:[T]){
            NotificationCenter.default.post(name: NSNotification.Name(name),
                                            object: self,
                                            userInfo: ["data":data])
            print("NotificationCenter.default.post")
        }
        
        func remove(observer: NSObjectProtocol){
            count -= 1
            NotificationCenter.default.removeObserver(observer, name: nil, object: nil)
        }
        
        
    }
    
}
