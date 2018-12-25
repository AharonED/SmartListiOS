//
//  FirebaseUsersManager.swift
//  SmartListIOS
//
//  Created by admin on 25/12/2018.
//  Copyright © 2018 Aharon.Garada. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

public class FirebaseUsersManager{
    
    //Auth

    init() {
       
    }

    static func signin(_ user: Users, callback:@escaping (_ success:Bool,_ user: Users)->Void) {
        Auth.auth().signIn(withEmail: user.email, password: user.password) { (authResult, error) in
            if (authResult != nil){
                user.id = authResult?.user.uid ?? user.email
                callback (true, user)
            }else{
                callback (false, user)
            }
        }
        
    }
    
    static func createUser(_ user: Users, callback:@escaping (_ success:Bool,_ user: Users, _ errorDesc:String)->Void) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { (authResult, error) in
            var errorDesc:String = ""
            
            if ((error?.localizedDescription) != nil)
            {
                errorDesc=error?.localizedDescription ?? ""
            }
            
            if (authResult?.user != nil) {
                user.id=authResult?.user.uid ?? user.email
                do{
                    try Model.addNew(instance: user)
                }
                catch let error {
                    errorDesc=error.localizedDescription
                }
                callback (true, user, errorDesc)
            }else{
                callback (false, user, errorDesc)
            }
        }
    }
    
    static func checkIfSignIn() -> Bool {
        return (Auth.auth().currentUser != nil)
    }
}
