//
//  ChecklistItemsReportedTableViewCell.swift
//  SmartListIOS
//
//  Created by admin on 14/03/2019.
//  Copyright © 2019 Aharon.Garada. All rights reserved.
//

import UIKit

class ChecklistItemsReportedTableViewCell: UITableViewCell {

    var view:UIViewController! = nil
    
    let model:Model<ChecklistItems> = Model<ChecklistItems>()

    public var selectedChecklistItem:ChecklistItems = ChecklistItems(_id: "",
                                                                     _name: "",
                                                                     _description: "",
                                                                     _checklistId:"",
                                                                     _owner:"",
                                                                     _itemType:"",
                                                                     _attributes: "",
                                                                     _itemIndex:0,
                                                                     _result:"",
                                                                     _lastUpdate:nil
    )
    
    
    @IBOutlet weak var save: UIButton!
    
    @IBOutlet weak var checklistItemResultTextField: UITextField!
    @IBOutlet weak var ChecklistItemNameTextField: UILabel!
    @IBOutlet weak var ChecklistItemDescTextField: UILabel!
    public var id:String=""
    
    
    @IBAction func saveClicked(_ sender: Any) {
        if(checklistItemResultTextField.text! == "")
        {
            //selectedChecklistItem.attributes.split(separator: ";").contains(checklistItemResultTextField!.text)
            if(selectedChecklistItem.attributes != "")
            {
                Utils.displayMessage(_controller: view, userMessage:  "Not valid Result, please set valid value (" + selectedChecklistItem.attributes + ")" )
            }
            else
            {
                Utils.displayMessage(_controller: view, userMessage:  "Not valid Result, please set valid value" )
            }
        }
        else
        {
            selectedChecklistItem.result = checklistItemResultTextField.text!
            self.saveChecklistItemInfo(url: "")
        }
    }
    
    
    
    func saveChecklistItemInfo(url:String)  {
        
        let chk:ChecklistItems = selectedChecklistItem
        
        do{
            //Add the new user also to Firebase Database
            try model.addNew(instance: chk)
        }
        catch let error {
            //let errorDesc:String = error.localizedDescription
            print("Unexpected error when adding new record: \(error.localizedDescription).")
        }
        
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
