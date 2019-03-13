//
//  ChecklistItemItemsViewController.swift
//  SmartListIOS
//
//  Created by admin on 11/03/2019.
//  Copyright © 2019 Aharon.Garada. All rights reserved.
//

import UIKit

class ChecklistItemsViewController: UITableViewController {

    public var checklistItemId:String=""
    public var checklistId:String=""
    
    @IBOutlet weak var navTitle: UINavigationItem!
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var data = [ChecklistItems]()
    var selectedChecklistItem:ChecklistItems?
    var selectedCell:ChecklistItemsTableViewCell?
    
    var ChecklistItemsListener:NSObjectProtocol?
    let model:Model<ChecklistItems> = Model<ChecklistItems>()
    var selectedId:String?
    var collectionName:String = ""
    
    public func setTitle()
    {
        navTitle.title="Checklist Items - " + checklistId
    }
    
    
    func getAllRecords()
    {
        model.getAllRecords(fieldName: ["checklistId"], fieldValue: [checklistId], uniqueInstanceIdentifier: getUniqueInstanceIdentifier())
        
 //       model.getAllRecords(fieldName: nil, fieldValue: nil, uniqueInstanceIdentifier: getUniqueInstanceIdentifier())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //getAllRecords()
    }
    
    func getUniqueInstanceIdentifier()->String
    {
        return "Checklist_Items"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ChecklistItemsViewController.viewDidLoad.checklistId \(checklistId).")
        
        
        let chk:ChecklistItems = ChecklistItems(_id: "Question-" + checklistId, _name: "ChecklistItem - " + checklistId , _description: "ChecklistItem Description", _checklistId:checklistId, _owner:((LoggedUser.user?.id)!), _itemType:"Options", _attributes: "true;false", _lastUpdate:nil )
        
        do{
            //Add the new user also to Firebase Database
            try model.addNew(instance: chk)
        }
        catch let error {
            //let errorDesc:String = error.localizedDescription
            print("Unexpected error: \(error.localizedDescription).")
        }
        
        setTitle()
        
        let dummy:BaseModelObject = ChecklistItems(_id: "", _name: "", _description: "", _checklistId:"", _owner:"", _itemType:"", _attributes: "", _lastUpdate: 0)
        collectionName = dummy.tableName
        dummy.UniqueInstanceIdentifier = getUniqueInstanceIdentifier()

        let notif = ModelNotification.GetNotification(collectionName: collectionName,dummy:dummy)
        if(notif.count>0)
        {
             ModelNotification.GetNotification(collectionName: collectionName,dummy:dummy).remove(observer: ChecklistItemsListener!)
            ChecklistItemsListener = notif.observe(){
                (data:Any) in
            print("GetNotification.observe()-ChecklistItemsListener")
            self.data = data as! [ChecklistItems]
            self.tableView.reloadData()
            } as NSObjectProtocol
        }
        
        getAllRecords()
        //model.getAllRecords(fieldName: nil, fieldValue: nil)
        
    }
    
    deinit{
        if ChecklistItemsListener != nil{
            let dummy:BaseModelObject = ChecklistItems(_id: "", _name: "", _description: "", _checklistId:"", _owner:"", _itemType:"", _lastUpdate: 0)
            collectionName = dummy.tableName
            dummy.UniqueInstanceIdentifier = getUniqueInstanceIdentifier()

            ModelNotification.GetNotification(collectionName: collectionName,dummy:dummy).remove(observer: ChecklistItemsListener!)
            //ModelNotification.ListNotification.removeValue(forKey: collectionName)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ChecklistItemsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItemCell", for: indexPath) as! ChecklistItemsTableViewCell
        
        let st = data[indexPath.row]
        cell.ChecklistItemNameTextField.text = st.name
        cell.ChecklistItemDescTextField.text = st.description
        cell.id = st.id
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("user select row \(indexPath.row)")
        selectedId = data[indexPath.row].id
        selectedChecklistItem = data[indexPath.row]
        selectedCell = tableView.cellForRow(at: indexPath) as? ChecklistItemsTableViewCell
        
        //self.performSegue(withIdentifier: "ChrcklistsSegue", sender: self)
    }
    
    /*
     @IBAction func AddChecklistItem(_ sender: Any) {
     self.performSegue(withIdentifier: "AddChecklistItemsegue", sender: self)
     }
     
     @IBAction func EditChecklistItem(_ sender: Any) {
     self.performSegue(withIdentifier: "ChecklistItemDetailsSegue", sender: self)
     }
     
     @IBAction func OpenChecklistItems(_ sender: Any) {
     self.performSegue(withIdentifier: "ChecklistItemsSegue", sender: self)
     }
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if segue.identifier == "ChecklistItemDetailsSegue"{
     let ChecklistItemDetailsVc:ChecklistItemDetailsViewController = segue.destination as! ChecklistItemDetailsViewController
     ChecklistItemDetailsVc.checklistItemId = self.selectedId!
     if(selectedChecklistItem != nil)
     {
     ChecklistItemDetailsVc.name = selectedChecklistItem!.name
     ChecklistItemDetailsVc.desc = selectedChecklistItem!.description
     ChecklistItemDetailsVc.imageUrl = selectedChecklistItem!.url
     if(selectedCell != nil)
     {
     ChecklistItemDetailsVc.uiImage = self.selectedCell!.ChecklistItemImageView?.image
     }
     }
     }
     
     if segue.identifier == "ChecklistItemsSegue"{
     let ChecklistItemsVc:MainViewController = segue.destination as! MainViewController
     ChecklistItemsVc.checklistItemId = self.selectedId!
     
     }
     
     
     
     }
     
     */


}
