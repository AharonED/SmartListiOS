//
//  MostGroupsListTableViewController.swift
//  SmartListIOS
//
//  Created by admin on 08/03/2019.
//  Copyright © 2019 Aharon.Garada. All rights reserved.
//

import UIKit

class MostGroupsListTableViewController: GroupsListTableViewController {

    override func setTitle()
    {
        navTitle.title="Most Popular Groups"
    }

    
    override func getAllRecords()
    {
        model.getAllRecords(fieldName: ["privacyType"], fieldValue: ["MostPop"], uniqueInstanceIdentifier: getUniqueInstanceIdentifier())
    }
    
    override func getUniqueInstanceIdentifier()->String
    {
        return "" // "Most_Groups"
    }
}
