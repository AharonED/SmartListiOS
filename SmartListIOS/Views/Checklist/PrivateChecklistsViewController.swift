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
        navTitle.title = groupName + "-Private Checklists"
    }
    
    
    
    override func getAllRecords()
    {
        model.getAllRecords(fieldName: ["owner","groupid"], fieldValue: [ (LoggedUser.user?.id)!,  groupId], uniqueInstanceIdentifier: getUniqueInstanceIdentifier())
    }
    
    override func getUniqueInstanceIdentifier()->String
    {
        return "Private_Checklists"
    }

    @IBAction override func checklistItems(_ sender: Any) {
        super.checklistItems(sender)
    }
    @IBAction override func editChecklist(_ sender: Any) {
        super.editChecklist(sender)
    }
    
    @IBAction override func newChecklist(_ sender: Any) {
        super.newChecklist(sender)
    }
}
