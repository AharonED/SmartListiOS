//
//  ChecklistsTabViewController.swift
//  SmartListIOS
//
//  Created by admin on 10/03/2019.
//  Copyright © 2019 Aharon.Garada. All rights reserved.
//

import UIKit

class ChecklistsTabViewController: UITabBarController {
    
    public var groupType:String=""
    public var ChecklistId:String=""
    public var groupId:String=""
    
    let tabPublic:Int=0
    let tabPrivate:Int=1
    let tabReported:Int=2
    
    @IBOutlet weak var tabControl: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ChecklistsTabViewController.viewDidLoad  groupType = \(groupType), groupId \(groupId)")
        
        var checklistsVc:ChecklistsViewController
        if (self.viewControllers?[tabPublic] is UINavigationController)
        {
            checklistsVc = (self.viewControllers?[tabPublic] as! UINavigationController).viewControllers[0]  as! ChecklistsViewController
            checklistsVc.groupId = self.groupId 
        }
        else if (self.viewControllers?[tabPublic] is ChecklistsViewController)
        {
            checklistsVc =  self.viewControllers?[tabPublic] as! ChecklistsViewController
            checklistsVc.groupId = self.groupId
        }

        

        var privateChecklistsVc:PrivateChecklistsViewController
        if (self.viewControllers?[tabPrivate] is UINavigationController)
        {
            privateChecklistsVc = (self.viewControllers?[tabPrivate] as! UINavigationController).viewControllers[0]  as! PrivateChecklistsViewController
            privateChecklistsVc.groupId = self.groupId
        }
        else if (self.viewControllers?[tabPrivate] is ChecklistsViewController)
        {
            privateChecklistsVc =  self.viewControllers?[tabPrivate] as! PrivateChecklistsViewController
            privateChecklistsVc.groupId = self.groupId
        }

        
        
        var reportedChecklistsVc:ReportedChecklistsViewController
        if (self.viewControllers?[tabReported] is UINavigationController)
        {
            reportedChecklistsVc = (self.viewControllers?[tabReported] as! UINavigationController).viewControllers[0]  as! ReportedChecklistsViewController
            reportedChecklistsVc.groupId = self.groupId
        }
        else if (self.viewControllers?[tabReported] is ChecklistsViewController)
        {
            reportedChecklistsVc =  self.viewControllers?[tabReported] as! ReportedChecklistsViewController
            reportedChecklistsVc.groupId = self.groupId
        }


        // Do any additional setup after loading the view.
    }
    
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*
        var tab = tabControl.selectedItem?.tag
        print("groupId \(groupId).")

        switch (segue.identifier)
        {
        case "MyChecklistsTabController":
            do{
                let checklistsVc:ChecklistsViewController = segue.destination as! ChecklistsViewController
                checklistsVc.groupId = self.groupId + "My"
            }
            break
        case "OtherChecklistsTabController":
            do{
                let checklistsVc:PrivateChecklistsViewController = segue.destination as! PrivateChecklistsViewController
                checklistsVc.groupId = self.groupId + "Other"
            }
            break
        case "MostChecklistsTabController":
            do{
                let checklistsVc:ReportedChecklistsViewController = segue.destination as! ReportedChecklistsViewController
                checklistsVc.groupId = self.groupId + "Most"
            }
            break
            
        default:
            do {
                
            }
        }
        */
        
     }
 
    
}
