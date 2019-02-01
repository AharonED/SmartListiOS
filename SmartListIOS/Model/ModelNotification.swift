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
    static let GroupsListNotification = MyNotification<[Groups]>("com.smartlist.groups")
    static let UsersListNotification = MyNotification<[Users]>("com.smartlist.users")

    class MyNotification<T>{
        let name:String
        var count = 0;
        
        init(_ _name:String) {
            name = _name
        }
        
        func observe(cb:@escaping (T)->Void)-> NSObjectProtocol{
            count += 1
            return NotificationCenter.default.addObserver(forName: NSNotification.Name(name),
                                                          object: nil, queue: nil) { (data) in
                                                            if let data = data.userInfo?["data"] as? T {
                                                                cb(data)
                                                            }
            }
        }
        
        func notify(data:T){
            NotificationCenter.default.post(name: NSNotification.Name(name),
                                            object: self,
                                            userInfo: ["data":data])
        }
        
        func remove(observer: NSObjectProtocol){
            count -= 1
            NotificationCenter.default.removeObserver(observer, name: nil, object: nil)
        }
        
        
    }
    
}
