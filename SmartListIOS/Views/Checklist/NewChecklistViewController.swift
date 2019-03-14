//
//  NewChecklistViewController.swift
//  SmartListIOS
//
//  Created by admin on 13/03/2019.
//  Copyright © 2019 Aharon.Garada. All rights reserved.
//

import UIKit

class NewChecklistViewController: UIViewController, UINavigationControllerDelegate {
    let model:Model<Checklists> = Model<Checklists>()
    var identifier = NSUUID().uuidString
    
    @IBOutlet weak var Caption: UILabel!
    
    public var name : String=""
    public var desc : String=""
   
    public var groupId:String=""
    public var checklistId:String=""

    public var checklistType:String="Template"
    
    public var editMode:Utils.EditMode = Utils.EditMode.Insert

    
    @IBOutlet weak var checklistNameTextField: UITextField!
    @IBOutlet weak var checklistDescriptionTextField: UITextField!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (checklistId != "" && editMode == Utils.EditMode.Edit)
        {
            Caption.text = "Edit Checklist"
            identifier = checklistId
            checklistNameTextField.text = name
            checklistDescriptionTextField.text = desc
        }
        
    }
    
    
    
    @IBAction func save(_ sender: Any) {
        if (checklistNameTextField.text! == "") {
            Utils.displayMessage(_controller: self, userMessage:  "Title field is required")
            return
        }
        
            self.saveChecklistInfo(url: "")
    }
    
    func saveChecklistInfo(url:String)  {
        
        let chk:Checklists = Checklists(_id: identifier,
                                        _name: checklistNameTextField.text!,
                                        _description: checklistDescriptionTextField.text!,
                                        _groupId:groupId,
                                        _owner:((LoggedUser.user?.id)!),
                                        _checklistType:checklistType,
                                        _url: "",
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
