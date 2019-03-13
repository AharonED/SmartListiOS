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
        //self.performSegue(withIdentifier: "ChecklistsSegue", sender: self)

    }
    
    @IBOutlet weak var navTitle: UINavigationItem!
    
    @IBAction func newChecklist(_ sender: Any) {
       // self.performSegue(withIdentifier: "AddChecklistsegue", sender: self)
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var data = [Checklists]()
    var selectedChecklist:Checklists?
    var selectedCell:ChecklistsTableViewCell?
    
    var ChecklistsListener:NSObjectProtocol?
    let model:Model<Checklists> = Model<Checklists>()
    var selectedId:String?
    var collectionName:String = ""
    
    public func setTitle()
    {
        navTitle.title = groupName + "-Public Checklists"
    }
    
    
    func getAllRecords()
    {
        model.getAllRecords(fieldName: ["groupid","CHECKLISTTYPE"], fieldValue: [groupId, "Template"], uniqueInstanceIdentifier: getUniqueInstanceIdentifier())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setListener()
        //getAllRecords()
        
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
        
        /*
        let chk:Checklists = Checklists(_id: "CHECK-" + groupId, _name: "Checklist - " + groupId , _description: "Checklist Description", _groupId:groupId, _owner:((LoggedUser.user?.id)!), _checklistType:"Template", _url: "", _lastUpdate:nil )
        
        do{
            //Add the new user also to Firebase Database
            try model.addNew(instance: chk)
        }
        catch let error {
            //let errorDesc:String = error.localizedDescription
            print("Unexpected error: \(error.localizedDescription).")
        }
        */
        
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
    
    /*
     @IBAction func AddChecklist(_ sender: Any) {
     self.performSegue(withIdentifier: "AddChecklistsegue", sender: self)
     }
     
     @IBAction func EditChecklist(_ sender: Any) {
     self.performSegue(withIdentifier: "ChecklistDetailsSegue", sender: self)
     }
     
     @IBAction func OpenChecklists(_ sender: Any) {
     self.performSegue(withIdentifier: "ChecklistsSegue", sender: self)
     }
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*
         if segue.identifier == "ChecklistDetailsSegue"{
         let ChecklistDetailsVc:ChecklistDetailsViewController = segue.destination as! ChecklistDetailsViewController
         ChecklistDetailsVc.ChecklistId = self.selectedId!
         if(selectedChecklist != nil)
         {
         ChecklistDetailsVc.name = selectedChecklist!.name
         ChecklistDetailsVc.desc = selectedChecklist!.description
         ChecklistDetailsVc.imageUrl = selectedChecklist!.url
         if(selectedCell != nil)
         {
         ChecklistDetailsVc.uiImage = self.selectedCell!.ChecklistImageView?.image
         }
         }
         }
         */
        if segue.identifier == "ChecklistsItemsSegue"{
            let checklistsItemsVc:ChecklistItemsViewController = segue.destination as! ChecklistItemsViewController
            checklistsItemsVc.checklistId = self.selectedId!
            
        }
        
    }
    
    
    
}
