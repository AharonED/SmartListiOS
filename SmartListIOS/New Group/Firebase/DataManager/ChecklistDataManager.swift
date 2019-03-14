//
//  CopyChecklist.swift
//  SmartListIOS
//
//  Created by admin on 14/03/2019.
//  Copyright © 2019 Aharon.Garada. All rights reserved.
//

import Foundation

public class ChecklistDataManager
{
    var ChecklistItemsListener:NSObjectProtocol?
    let modelItems:Model<ChecklistItems> = Model<ChecklistItems>()
    var data = [ChecklistItems]()
    var chkCopy:Checklists!
    var  checklistIdentifier:String!
    
    public func CopyChecklist(checklist: Checklists) -> Checklists
    {
        chkCopy = Checklists(json: (checklist.toJson())) // Make a byValue copy
        let identifier = NSUUID().uuidString
        chkCopy.id = identifier
        checklistIdentifier = identifier
        chkCopy.checklistType = "Reported"
        chkCopy.name = "" + chkCopy.name
        

        ////////////////////////////////////
        let date : Date = Date()
               let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        //print(dateFormatterPrint.string(from: date))
        
        chkCopy.description = dateFormatterPrint.string(from: date) + " - " +  chkCopy.description
        ////////////////////////////////////

        
        do{
            let modelChecklists:Model<Checklists> = Model<Checklists>()

            //Add the new Checklist to Firebase Database
            try modelChecklists.addNew(instance: chkCopy)
        }
        catch let error {
            //let errorDesc:String = error.localizedDescription
            print("Unexpected error when adding new record: \(error.localizedDescription).")
        }
        
        setListener()
        
        modelItems.getAllRecords(fieldName: ["checklistId"], fieldValue: [checklist.id], uniqueInstanceIdentifier: "CopyChecklist")
        
        ////Add the new user also to Firebase Database
        //try model.addNew(instance: chkCopy)
        
        return chkCopy
     }
    
    func CopyData(items: [ChecklistItems])
    {
        for item in items{
            let chkItemCopy:ChecklistItems = ChecklistItems(json: (item.toJson())) // Make a byValue copy
            let identifier = NSUUID().uuidString
            chkItemCopy.id = identifier
            chkItemCopy.name = "" + chkItemCopy.name
            chkItemCopy.checklistId = checklistIdentifier
            
            
            do{
                //Add the new Checklist to Firebase Database
                try modelItems.addNew(instance: chkItemCopy)
            }
            catch let error {
                //let errorDesc:String = error.localizedDescription
                print("Unexpected error when adding new record: \(error.localizedDescription).")
            }
        }
    }
    
    func setListener()
    {
        
        let dummy:BaseModelObject = ChecklistItems(_id: "", _name: "", _description: "", _checklistId:"", _owner:"", _itemType:"", _attributes: "", _itemIndex:0,_result:"", _lastUpdate: 0)
        let collectionName = dummy.tableName
        dummy.UniqueInstanceIdentifier = "CopyChecklist"//getUniqueInstanceIdentifier()
        
        let notif = ModelNotification.GetNotification(collectionName: collectionName,dummy:dummy)
        if(notif.count==0)
        {
            ChecklistItemsListener = notif.observe(){
                (data:Any) in
                print("GetNotification.observe()-ChecklistItemsListener")
                self.data = data as! [ChecklistItems]
                self.CopyData(items: self.data)
                
                self.removeListener()
                } as NSObjectProtocol
        }
    }
    
    func removeListener()
    {
        if ChecklistItemsListener != nil{
            let dummy:BaseModelObject = ChecklistItems(_id: "", _name: "", _description: "", _checklistId:"", _owner:"", _itemType:"", _itemIndex:0,_result:"", _lastUpdate: 0)
            let collectionName = dummy.tableName
            dummy.UniqueInstanceIdentifier = "CopyChecklist"//getUniqueInstanceIdentifier()
            
            ModelNotification.GetNotification(collectionName: collectionName,dummy:dummy).remove(observer: ChecklistItemsListener!)
            //ModelNotification.ListNotification.removeValue(forKey: collectionName)
        }
    }
}
