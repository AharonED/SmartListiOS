//
//  MainViewController.swift
//  SmartListIOS
//
//  Created by admin on 25/12/2018.
//  Copyright © 2018 Aharon.Garada. All rights reserved.
//
 
import UIKit

class MainViewController: UITabBarController {

    public var groupId:String=""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChecklistsViewController"{
            let groupDetailsVc:GroupDetailsViewController = segue.destination as! GroupDetailsViewController
            groupDetailsVc.groupId = self.groupId
        }
       
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
