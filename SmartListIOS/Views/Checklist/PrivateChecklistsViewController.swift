//
//  ChecklistsViewController.swift
//  SmartListIOS
//
//  Created by admin on 25/12/2018.
//  Copyright © 2018 Aharon.Garada. All rights reserved.
//
 
import UIKit

class PrivateChecklistsViewController : ChecklistsViewController {

    @IBAction override func back(_ sender: Any) {
        super.back(sender)
    }
    
    override func setTitle()
    {
        navTitle.title="Private Checklists"
    }
    
    
    
    override func getAllRecords()
    {
        model.getAllRecords(fieldName: ["owner","groupid"], fieldValue: [ (LoggedUser.user?.id)!,  groupId])
    }
   
}
