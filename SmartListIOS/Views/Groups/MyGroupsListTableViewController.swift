//
//  MyGroupsListTableViewController.swift
//  SmartListIOS
//
//  Created by admin on 08/03/2019.
//  Copyright © 2019 Aharon.Garada. All rights reserved.
//

import UIKit

class MyGroupsListTableViewController: GroupsListTableViewController {

    override func setTitle()
    {
        navTitle.title="My Groups"
    }

    
    override func getAllRecords()
    {
        model.getAllRecords(fieldName: ["OWNER"], fieldValue: [(LoggedUser.user?.id)!], uniqueInstanceIdentifier: getUniqueInstanceIdentifier())
    }
    
    override func getUniqueInstanceIdentifier()->String
    {
        return "" // "My_Groups"
    }
}
