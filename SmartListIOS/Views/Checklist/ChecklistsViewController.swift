//
//  ChecklistsViewController.swift
//  SmartListIOS
//
//  Created by admin on 24/02/2019.
//  Copyright © 2019 Aharon.Garada. All rights reserved.
//

import UIKit

class ChecklistsViewController: UITableViewController {
    
    public var ChecklistId:String=""
    public var groupId:String=""
    public var groupName : String=""

    
    var data = [Checklists]()
    var selectedChecklist:Checklists?
    var selectedCell:ChecklistsTableViewCell?
    
    var ChecklistsListener:NSObjectProtocol?
    let model:Model<Checklists> = Model<Checklists>()
    var selectedId:String?
    var collectionName:String = ""
    
    var checklistType = "Tempalte"
    
    
    @IBAction func ReportChecklist(_ sender: Any) {
        if(self.selectedId != nil)
        {
            self.performSegue(withIdentifier: "ReportChecklistsItemsSegue", sender: self)
        }
        else
        {
            Utils.displayMessage(_controller: self, userMessage:  "Select Checklist for start reporting...")
        }
    }
    
    
    @IBAction func checklistItems(_ sender: Any) {
        if(self.selectedId != nil)
        {
            self.performSegue(withIdentifier: "ChecklistsItemsSegue", sender: self)
        }
        else
        {
            Utils.displayMessage(_controller: self, userMessage:  "Select Checklist for editing...")
        }
    }
    
    @IBAction func editChecklist(_ sender: Any) {
        if(self.selectedId != nil)
        {
            self.performSegue(withIdentifier: "EditChecklistSegue", sender: self)
        }
        else
        {
            Utils.displayMessage(_controller: self, userMessage:  "Select Checklist for editing...")
        }
    }
    
    @IBOutlet weak var navTitle: UINavigationItem!
    
    @IBAction func newChecklist(_ sender: Any) {
       self.performSegue(withIdentifier: "AddChecklistSegue", sender: self)
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    public func setTitle()
    {
        navTitle.title = "Checklists - " + groupName
    }
    
    
    func getAllRecords()
    {
        model.getAllRecords(fieldName: ["groupid","CHECKLISTTYPE"], fieldValue: [groupId, "Template"], uniqueInstanceIdentifier: getUniqueInstanceIdentifier())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setListener()
        getAllRecords()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        removeListener()
    }
    
    func getUniqueInstanceIdentifier()->String
    {
        return "Public_Checklists"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ChecklistsViewController.viewDidLoad.groupId \(groupId).")
     
        setTitle()
        
        setListener()
        getAllRecords()
        //model.getAllRecords(fieldName: nil, fieldValue: nil)
        
    }
    
    func setListener()
    {
        let dummy:BaseModelObject = Checklists(_id: "", _name: "", _description: "", _groupId:"", _owner:"", _checklistType:"", _url: "", _lastUpdate: 0)
        collectionName = dummy.tableName
        dummy.UniqueInstanceIdentifier = getUniqueInstanceIdentifier()
        
        let notif = ModelNotification.GetNotification(collectionName: collectionName,dummy:dummy)
        if(notif.count==0)
        {
            ChecklistsListener = notif.observe(){
                (data:Any) in
                print("GetNotification.observe()-ChecklistsListener")
                self.data = data as! [Checklists]
                self.tableView.reloadData()
                } as NSObjectProtocol
        }
    }
    
    func removeListener()
    {
        if ChecklistsListener != nil{
            let dummy:BaseModelObject = Checklists(_id: "", _name: "", _description: "", _groupId:"", _owner:"", _checklistType:"", _lastUpdate: 0)
            collectionName = dummy.tableName
            dummy.UniqueInstanceIdentifier = getUniqueInstanceIdentifier()
            
            ModelNotification.GetNotification(collectionName: collectionName,dummy:dummy).remove(observer: ChecklistsListener!)
            //ModelNotification.ListNotification.removeValue(forKey: collectionName)
        }
    }
    
    deinit{
        removeListener()
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
        let cell:ChecklistsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ChecklistCell", for: indexPath) as! ChecklistsTableViewCell
        
        let st = data[indexPath.row]
        cell.ChecklistNameTextField.text = st.name
        cell.ChecklistDescTextField.text = st.description
        cell.id = st.id
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("user select row \(indexPath.row)")
        selectedId = data[indexPath.row].id
        selectedChecklist = data[indexPath.row]
        selectedCell = tableView.cellForRow(at: indexPath) as? ChecklistsTableViewCell
        
        //self.performSegue(withIdentifier: "ChrcklistsSegue", sender: self)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChecklistsItemsSegue"{
            let checklistsItemsVc:ChecklistItemsViewController = segue.destination as! ChecklistItemsViewController
            checklistsItemsVc.checklistId = self.selectedId!
            checklistsItemsVc.checklistType = self.checklistType
            checklistsItemsVc.checklistName = (self.selectedChecklist?.name)!
        }
        
        
        if segue.identifier == "ReportChecklistsItemsSegue"{
            let checklistsItemsVc:ChecklistItemsViewController = segue.destination as! ChecklistItemsViewController
            
            var dm:ChecklistDataManager = ChecklistDataManager()
            var chkCopy:Checklists = dm.CopyChecklist(checklist: self.selectedChecklist!)
            
            /*
            let chkCopy:Checklists = Checklists(json: (self.selectedChecklist?.toJson())!) // Make a byValue copy
            let identifier = NSUUID().uuidString
            chkCopy.id = identifier
            chkCopy.checklistType = "Reported"
            chkCopy.name = "Copy of" + chkCopy.name 
            
          
            do{
                //Add the new Checklist to Firebase Database
                try model.addNew(instance: chkCopy)
            }
            catch let error {
                //let errorDesc:String = error.localizedDescription
                print("Unexpected error when adding new record: \(error.localizedDescription).")
            }
            
            let modelItems:Model<ChecklistItems> = Model<ChecklistItems>()
            modelItems.getAllRecords(fieldName: ["checklistId"], fieldValue: [identifier], uniqueInstanceIdentifier: getUniqueInstanceIdentifier())
            
            ////Add the new user also to Firebase Database
            //try model.addNew(instance: chkCopy)
*/
            checklistsItemsVc.checklistId = chkCopy.id// identifier
            checklistsItemsVc.checklistType = "Reported"
            checklistsItemsVc.checklistName = chkCopy.name
 
            
        }
        
        if segue.identifier == "AddChecklistSegue"{
            let checklistVc:NewChecklistViewController = segue.destination as! NewChecklistViewController
            checklistVc.groupId = self.groupId
            checklistVc.checklistType = self.checklistType
            checklistVc.editMode = Utils.EditMode.Insert

            checklistVc.checklistId = ""
        }

        
        if segue.identifier == "EditChecklistSegue"{
            let checklistVc:NewChecklistViewController = segue.destination as! NewChecklistViewController
            checklistVc.groupId = self.groupId
            checklistVc.checklistType = self.checklistType
            checklistVc.editMode = Utils.EditMode.Edit
            
            checklistVc.checklistId = self.selectedId!
            checklistVc.name = (self.selectedChecklist?.name)!
            checklistVc.desc = (self.selectedChecklist?.description)!
        }
        
       
        
    }
    
    
    
}
