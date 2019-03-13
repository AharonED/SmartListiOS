//
//  ReportedChecklistsViewController.swift
//  SmartListIOS
//
//  Created by admin on 10/03/2019.
//  Copyright © 2019 Aharon.Garada. All rights reserved.
//

import Foundation

class ReportedChecklistsViewController : ChecklistsViewController {
    
    @IBAction override func back(_ sender: Any) {
        super.back(sender)
    }
    
    override func setTitle()
    {
        navTitle.title = groupName + "-Reported Checklists_" + groupId
    }
    
    override func getAllRecords()
    {
        model.getAllRecords(fieldName: ["owner","groupid","CHECKLISTTYPE"], fieldValue: [ (LoggedUser.user?.id)!,  groupId, "Reported"], uniqueInstanceIdentifier: getUniqueInstanceIdentifier())
    }
    
    override func getUniqueInstanceIdentifier()->String
    {
        return "Reported_Checklists"
    }
    
    @IBAction override func checklistItems(_ sender: Any) {
    }
    @IBAction override func editChecklist(_ sender: Any) {
    }
    @IBAction override func newChecklist(_ sender: Any) {
    }
}
