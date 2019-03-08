//
//  SignInViewController.swift
//  SmartListIOS
//
//  Created by admin on 01/12/2018.
//  Copyright © 2018 Aharon.Garada. All rights reserved.
//
import UIKit
import Firebase

//import SwiftKeychainWrapper

class SignInViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    let indicator:Indicator = Indicator()

    override func viewDidLoad() {
        super.viewDidLoad()
  
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        print("Sign in button tapped")
        
        // Read values from text fields
        let userName = userNameTextField.text
        let userPassword = userPasswordTextField.text
        
        // Check if required fields are not empty
        if (userName?.isEmpty)! || (userPassword?.isEmpty)!
        {
            // Display alert message here
            print("User name \(String(describing: userName)) or password \(String(describing: userPassword)) is empty")
            Utils.displayMessage(_controller: self, userMessage: "One of the required fields is missing")
            
            return
        }
        
  
        do {
            indicator.show(view: view)
            let user:Users = Users(_id:userName!, _firstName:"", _lastName:"", _email:userName!, _password:userPassword!)
            try FirebaseUsersManager.signin(user, callback: loginUser)
        }
        catch let error {
            print(error.localizedDescription)
            Utils.displayMessage(_controller: self, userMessage: "Something went wrong. Try again.")
            indicator.hide()
            return
        }
        
        
    }
    
    //CreateUser callback
    func loginUser (success:Bool, user:Users,errorDesc:String) -> Void {
        if (success == true) {
            if (user.id.isEmpty)
            {
                Utils.displayMessage(_controller: self, userMessage:  "Could not successfully perform this request. Please try again later")
            } else {
                Utils.displayMessage(_controller: self, userMessage: "Successfully Signed in",  CloseParent: true) {(param) in
                    DispatchQueue.main.async
                        {
                            /*
                            let homePage = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                            let appDelegate = UIApplication.shared.delegate
                            appDelegate?.window??.rootViewController = homePage
                            */
                            
                            let homePage = self.storyboard?.instantiateViewController(withIdentifier: "GroupsTabViewController") as! GroupsTabViewController
                            let appDelegate = UIApplication.shared.delegate
                            appDelegate?.window??.rootViewController = homePage
                    }
                }
              }
        }
        else
        {
            Utils.displayMessage(_controller: self, userMessage: errorDesc)
        }
        indicator.hide()
    }
    
    
    @IBAction func registerNewAccountButtonTapped(_ sender: Any) {
        print("Register account button tapped")
        
        let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterUserViewController") as! RegisterUserViewController
        
        self.present(registerViewController, animated: true)
 
    }
    

    
   

}
