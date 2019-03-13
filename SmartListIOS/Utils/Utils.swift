//
//  Utils.swift
//  SmartListIOS
//
//  Created by admin on 25/12/2018.
//  Copyright © 2018 Aharon.Garada. All rights reserved.
//

import Foundation
import UIKit

public class Utils{
    
    public enum EditMode:Int
    {
        case Insert = 1 , Edit
    }
    
    public static func displayMessage(_controller:UIViewController, userMessage:String, CloseParent:Bool = false) -> Void {
        DispatchQueue.main.async
            {
                let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                    // Code in this block will trigger when OK button tapped.
                    print("Ok button tapped")
                    DispatchQueue.main.async
                        {
                            alertController.dismiss(animated: true, completion: nil)
                            if(CloseParent){
                                _controller.dismiss(animated: true, completion: nil)
                          }
                    }
                }
                alertController.addAction(OKAction)
                _controller.present(alertController, animated: true, completion:nil)
        }
    }
    
    public static func displayMessage(_controller:UIViewController, userMessage:String, CloseParent:Bool = false
        , callback:@escaping (_ param:String)->Void
        ) -> Void {
        DispatchQueue.main.async
            {
                let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                    // Code in this block will trigger when OK button tapped.
                    print("Ok button tapped")
                    DispatchQueue.main.async
                        {
                            alertController.dismiss(animated: true, completion: nil)
                            
                            callback("")
                            
                            if(CloseParent){
                                _controller.dismiss(animated: true, completion: nil)
                            }
                    }
                }
                alertController.addAction(OKAction)
                _controller.present(alertController, animated: true, completion:nil)
        }
    }
    
 }
