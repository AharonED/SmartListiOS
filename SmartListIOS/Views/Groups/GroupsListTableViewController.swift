//
//  GroupsListTableViewController.swift
//  SmartListIOS
//
//  Created by admin on 25/12/2018.
//  Copyright © 2018 Aharon.Garada. All rights reserved.
//
 
import UIKit

class GroupsListTableViewController: UITableViewController {

    @IBOutlet weak var navTitle: UINavigationItem!
    
    var data = [Groups]()
    var groupsListener:NSObjectProtocol?
    let model:Model<Groups> = Model<Groups>()
    var selectedId:String?
    var collectionName:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let grp:Groups = Groups(_id: "6", _name: "Group6", _description: "Group 6 Description", _url: "", _lastUpdate:nil)
        
        do{
            //Add the new user also to Firebase Database
            try model.addNew(instance: grp)
        }
        catch let error {
            //let errorDesc:String = error.localizedDescription
            print("Unexpected error: \(error.localizedDescription).")
        }
        
        navTitle.title=grp.name

        let dummy:BaseModelObject = Groups(_id: "", _name: "", _description: "", _lastUpdate: 0)
        collectionName = dummy.tableName
        
        groupsListener = ModelNotification.GetNotification(collectionName: collectionName,dummy:dummy).observe(){
            (data:Any) in
            self.data = data as! [Groups]
            self.tableView.reloadData()
             print("GetNotification.observe()")
            } as NSObjectProtocol
        
/*
        groupsListener = ModelNotification.GroupsListNotification.observe(){
            (data:Any) in
            self.data = data as! [Groups]
            self.tableView.reloadData()
            print("GroupsListNotification.observe()")
            } as NSObjectProtocol
*/
        
        model.getAllRecords()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    deinit{
        if groupsListener != nil{
            let dummy:BaseModelObject = Groups(_id: "", _name: "", _description: "", _lastUpdate: 0)
            collectionName = dummy.tableName
            ModelNotification.GetNotification(collectionName: collectionName,dummy:dummy).remove(observer: groupsListener!)
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
        let cell:GroupsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupsTableViewCell
        
        let st = data[indexPath.row]
        cell.groupNameTextField.text = st.name
        cell.groupDescriptionTextField.text = st.description
        cell.id = st.id
        cell.imageView?.image = UIImage(named: "group")
        cell.imageView!.tag = indexPath.row
        if st.url != "" {
            model.getImage(url: st.url) { (image:UIImage?) in
                if (cell.imageView!.tag == indexPath.row){
                    if image != nil {
                        cell.imageView?.image = image!
                    }
                }
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("user select row \(indexPath.row)")
        selectedId = data[indexPath.row].id
        self.performSegue(withIdentifier: "ChrcklistsSegue", sender: self)
    }

    
    @IBAction func AddGroup(_ sender: Any) {
         self.performSegue(withIdentifier: "AddGroupSegue", sender: self)
    }
    
    @IBAction func EditGroup(_ sender: Any) {
         self.performSegue(withIdentifier: "GroupDetailsSegue", sender: self)
    }
    
    @IBAction func OpenChecklists(_ sender: Any) {
         self.performSegue(withIdentifier: "ChrcklistsSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GroupDetailsSegue"{
            let groupDetailsVc:GroupDetailsViewController = segue.destination as! GroupDetailsViewController
            groupDetailsVc.groupId = self.selectedId!
            
        }
        
        if segue.identifier == "ChrcklistsSegue"{
            let checklistsVc:MainViewController = segue.destination as! MainViewController
            checklistsVc.groupId = self.selectedId!
            
        }
        
        
        
    }
    
    // MARK: - Table view data source
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
*/
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
