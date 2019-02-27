//
//  GroupDetailsViewController.swift
//  SmartListIOS
//
//  Created by admin on 24/02/2019.
//  Copyright © 2019 Aharon.Garada. All rights reserved.
//

import UIKit

class GroupDetailsViewController:  UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let model:Model<Groups> = Model<Groups>()
    var identifier = ""//NSUUID().uuidString
    var image:UIImage?

    public var name : String=""
    public var desc : String=""
    public var imageUrl : String=""
    public var groupId : String=""

    public var uiImage : UIImage?

    
    
    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var groupDescriptionTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    

    override func viewDidLoad() {
    super.viewDidLoad()

        if (groupId != "")
        {
            identifier = groupId
            groupNameTextField.text = name
            groupDescriptionTextField.text = desc
            /*if(imageUrl != "")
            {
                imageView.image = UIImage.load(image: imageUrl)
                image = imageView.image
            }
            */
            
            if(uiImage != nil)
            {
                imageView.image = uiImage
                image = uiImage
            }
        }
    }
    
    
    
    @IBAction func takeImage(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self //as!  & UINavigationControllerDelegate
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
            }
        else
        {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType =
            UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // UIImagePickerControllerDelegate (from base class...)
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        image = info["UIImagePickerControllerOriginalImage"] as? UIImage
        imageView.image = image
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        if image != nil {
            let imageIdentifier = NSUUID().uuidString
            model.saveImage(image: image!, name: imageIdentifier){ (url:String?) in
                var _url = ""
                if url != nil {
                    _url = url!
                    }
                self.saveGroupInfo(url: _url)
            }
        }else{
            self.saveGroupInfo(url: "")
            }
    }
    
    func saveGroupInfo(url:String)  {
    
    let grp:Groups = Groups(_id: identifier, _name: groupNameTextField.text!, _description: groupDescriptionTextField.text!, _url: url, _lastUpdate:nil)
    
    do{
    //Add the new user also to Firebase Database
    try model.addNew(instance: grp)
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
