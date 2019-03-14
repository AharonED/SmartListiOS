//
//  ChecklistItemViewController.swift
//  SmartListIOS
//
//  Created by admin on 13/03/2019.
//  Copyright © 2019 Aharon.Garada. All rights reserved.
//

import UIKit

class ChecklistItemViewController: UIViewController {
    let model:Model<ChecklistItems> = Model<ChecklistItems>()
    var identifier = NSUUID().uuidString
    
    @IBOutlet weak var Caption: UILabel!
    
    public var checklistId:String=""
    public var checklistItemId:String=""
    var checklistType = "Template"

    public var checklistItemType:String="Text"
    //public var checklistItemAttributes:String=""
    
    public var editMode:Utils.EditMode = Utils.EditMode.Insert
    
    
    //public var name : String=""
    //public var desc : String=""
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
    

  
    @IBOutlet weak var checklistItemNameTextField: UITextField!
    
    @IBOutlet weak var checklistItemDescriptionTextField: UITextField!
    @IBOutlet weak var checklistItemAttributesTextField: UITextField!
    @IBOutlet weak var checklistItemIndexTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (checklistItemId != "" && editMode == Utils.EditMode.Edit)
        {
            Caption.text = "Edit Item"
            identifier = checklistItemId
            checklistItemNameTextField.text = selectedChecklistItem.name
            checklistItemDescriptionTextField.text = selectedChecklistItem.description
            checklistItemAttributesTextField.text = selectedChecklistItem.attributes
            checklistItemIndexTextField.text = String(selectedChecklistItem.itemIndex)
            //checklistItemResultTextField.text = selectedChecklistItem.result

            
        }
        
        if(checklistType=="Reported")
        {
            
        }
    }
    
    
    
    @IBAction func save(_ sender: Any) {
        var num = Int(checklistItemIndexTextField.text!)
        if num != nil {
            self.saveChecklistItemInfo(url: "")
        }
        else {
            Utils.displayMessage(_controller: self, userMessage:  "Not valid Item Index, please set numeriv value")
        }
        
    }
    
    func saveChecklistItemInfo(url:String)  {
        
        let chk:ChecklistItems = ChecklistItems(_id: identifier,
                                        _name: checklistItemNameTextField.text!,
                                        _description: checklistItemDescriptionTextField.text!,
                                        _checklistId:checklistId,
                                        _owner:((LoggedUser.user?.id)!),
                                        _itemType:checklistItemType,
                                        _attributes: checklistItemAttributesTextField.text!,
                                        _itemIndex:Int32(checklistItemIndexTextField.text!)!,
                                        _result:"",
                                        _lastUpdate:nil
        )
        
        do{
            //Add the new user also to Firebase Database
            try model.addNew(instance: chk)
        }
        catch let error {
            //let errorDesc:String = error.localizedDescription
            print("Unexpected error when adding new record: \(error.localizedDescription).")
        }
        
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        print("Cancel button tapped")
        
        self.dismiss(animated: true, completion: nil)
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
