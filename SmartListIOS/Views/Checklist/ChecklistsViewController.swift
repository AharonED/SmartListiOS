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
    
    @IBOutlet weak var navTitle: UINavigationItem!
   
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
        navTitle.title="Public Checklists"
    }
    
    
    func getAllRecords()
    {
        model.getAllRecords(fieldName: ["groupid"], fieldValue: [groupId])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getAllRecords()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ChecklistsViewController.viewDidLoad.groupId \(groupId).")

        
        let chk:Checklists = Checklists(_id: "CHECK-" + groupId, _name: "Checklist - " + groupId , _description: "Checklist Description", _groupId:groupId, _owner:((LoggedUser.user?.id)!), _checklistType:"", _url: "", _lastUpdate:nil )
        
        do{
            //Add the new user also to Firebase Database
            try model.addNew(instance: chk)
        }
        catch let error {
            //let errorDesc:String = error.localizedDescription
            print("Unexpected error: \(error.localizedDescription).")
        }
        
        setTitle()
        
        let dummy:BaseModelObject = Checklists(_id: "", _name: "", _description: "", _groupId:"", _owner:"", _checklistType:"", _url: "", _lastUpdate: 0)
        collectionName = dummy.tableName
        
        ChecklistsListener = ModelNotification.GetNotification(collectionName: collectionName,dummy:dummy).observe(){
            (data:Any) in
            self.data = data as! [Checklists]
            self.tableView.reloadData()
            print("GetNotification.observe()")
            } as NSObjectProtocol
        
       
        getAllRecords()
        //model.getAllRecords(fieldName: nil, fieldValue: nil)
      
    }
    
    deinit{
        if ChecklistsListener != nil{
            let dummy:BaseModelObject = Checklists(_id: "", _name: "", _description: "", _groupId:"", _owner:"", _checklistType:"", _lastUpdate: 0)
            collectionName = dummy.tableName
            ModelNotification.GetNotification(collectionName: collectionName,dummy:dummy).remove(observer: ChecklistsListener!)
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
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
     
     if segue.identifier == "ChecklistsSegue"{
     let checklistsVc:MainViewController = segue.destination as! MainViewController
     checklistsVc.ChecklistId = self.selectedId!
     
     }
     
     
     
     }
     
     */

}
