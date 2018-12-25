//
//  RegisterUserViewController.swift
//  SmartListIOS
//
//  Created by admin on 01/12/2018.
//  Copyright © 2018 Aharon.Garada. All rights reserved.
import UIKit
import Firebase

class RegisterUserViewController: UIViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    let indicator:Indicator = Indicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        print("Cancel button tapped")
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        print("Sign up button tapped")
        
        // Validate required fields are not empty
        if (firstNameTextField.text?.isEmpty)! ||
            (lastNameTextField.text?.isEmpty)! ||
            (emailAddressTextField.text?.isEmpty)! ||
            (passwordTextField.text?.isEmpty)!
        {
            // Display Alert message and return
            Utils.displayMessage(_controller: self, userMessage: "All fields are quired to fill in")
            return
        }
        
        // Validate password
        if ((passwordTextField.text?.elementsEqual(repeatPasswordTextField.text!))! != true)
        {
            // Display alert message and return
            Utils.displayMessage(_controller: self, userMessage: "Please make sure that passwords match")
            return
        }
       
        
       
        //--------------------------
        let email:String = emailAddressTextField.text!
        let password:String = passwordTextField.text!
        let firstName:String = firstNameTextField.text!
        let lastName:String = lastNameTextField.text!

         do {
           indicator.show(view: view)
           var user:Users = Users(_id:email, _firstName:firstName, _lastName:lastName, _email:email, _password:password)
           try FirebaseUsersManager.createUser(user, callback: createUser)
         }
        catch let error {
            print(error.localizedDescription)
            Utils.displayMessage(_controller: self, userMessage: "Something went wrong. Try again.")
            indicator.hide()
            return
        }
    }
    
    //CreateUser callback 
    func createUser (success:Bool, user:Users,errorDesc:String) -> Void {
        if (success == true) {
            if (user.id.isEmpty)
            {
                Utils.displayMessage(_controller: self, userMessage:  "Could not successfully perform this request. Please try again later")
            } else {
                Utils.displayMessage(_controller: self, userMessage:  "Successfully Registered a New Account. Please proceed to Sign in", CloseParent: true)
            }
            
        }
        else
        {
            Utils.displayMessage(_controller: self, userMessage: errorDesc)
       }
       indicator.hide()
    }
        
    
}
