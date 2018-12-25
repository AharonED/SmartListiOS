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
            displayMessage(userMessage: "All fields are quired to fill in")
            return
        }
        
        // Validate password
        if ((passwordTextField.text?.elementsEqual(repeatPasswordTextField.text!))! != true)
        {
            // Display alert message and return
            displayMessage(userMessage: "Please make sure that passwords match")
            return
        }
        
        //Create Activity Indicator
        let myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        
        // Position Activity Indicator in the center of the main view
        myActivityIndicator.center = view.center
        
        // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = false
        
        // Start Activity Indicator
        myActivityIndicator.startAnimating()
        
        view.addSubview(myActivityIndicator)
        
        //--------------------------
        let email:String = emailAddressTextField.text!
        let password:String = passwordTextField.text!
        let firstName:String = firstNameTextField.text!
        let lastName:String = lastNameTextField.text!

         do {
            var user:Users = Users(_id:email, _firstName:firstName, _lastName:lastName, _email:email, _password:password)
            FirebaseUsersManager.createUser(user, callback: createUser)
          
            
            /*
            //try
                Auth.auth().createUser(withEmail: email, password: password)
                { (authResult, error) in
            
                if ((error?.localizedDescription) != nil)
                {
                    self.displayMessage(userMessage: (error?.localizedDescription)!)
                    return
                }
                guard let user = authResult?.user else { return }
                let userId:String = user.uid
                print("User id: \(String(describing: userId))")
            
                if (userId.isEmpty)
                {
                    
                    self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                    return
                } else {
                    self.displayMessage(userMessage: "Successfully Registered a New Account. Please proceed to Sign in")
                }
                    
                   
                    
                    let model:Model = Model()
                    
                    let userObj:Users = Users(_id: userId, _name: email, _email: email, _password: password)
                    model.addNew(instance: userObj)
                    
            
            }
            */
        }
        //catch let error {
        //    print(error.localizedDescription)
        //    displayMessage(userMessage: "Something went wrong. Try again.")
        //    return
       // } 
        

        //-----------------------------------------------------------------
        /*
        // Send HTTP Request to Register user
        let myUrl = URL(string: "http://localhost:8080/api/users")
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"// Compose a query string
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let postString = ["firstName": firstNameTextField.text!,
                          "lastName": lastNameTextField.text!,
                          "email": emailAddressTextField.text!,
                          "password": passwordTextField.text!,
                          ] as [String: String]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            displayMessage(userMessage: "Something went wrong. Try again.")
            return
        }
        
     let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
        
        self.removeActivityIndicator(activityIndicator: myActivityIndicator)
        
        if error != nil
        {
            self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
            print("error=\(String(describing: error))")
            return
        }
        
        
        //Let's convert response sent from a server side code to a NSDictionary object:
        do {
            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
            
            if let parseJSON = json {
                
                
                let userId = parseJSON["userId"] as? String
                print("User id: \(String(describing: userId!))")
                
                if (userId?.isEmpty)!
                {
                    // Display an Alert dialog with a friendly error message
                    self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                    return
                } else {
                    self.displayMessage(userMessage: "Successfully Registered a New Account. Please proceed to Sign in")
                }
                
            } else {
                //Display an Alert dialog with a friendly error message
                self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
            }
        } catch {
            
            self.removeActivityIndicator(activityIndicator: myActivityIndicator)
            
            // Display an Alert dialog with a friendly error message
            self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
            print(error)
        }
        }
        
        task.resume()
        */
        
    }
    
    func createUser (success:Bool, user:Users,errorDesc:String) -> Void {
        if (success == true) {
            if (user.id.isEmpty)
            {
                self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
            } else {
                self.displayMessage(userMessage: "Successfully Registered a New Account. Please proceed to Sign in")
            }
            
        }
        else
        {
            self.displayMessage(userMessage: (errorDesc))
            return
        }
    }
        
      func removeActivityIndicator(activityIndicator: UIActivityIndicatorView)
        {
            DispatchQueue.main.async
             {
                    activityIndicator.stopAnimating()
                    activityIndicator.removeFromSuperview()
            }
        }
        
    
    func displayMessage(userMessage:String) -> Void {
        DispatchQueue.main.async
            {
                let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                    // Code in this block will trigger when OK button tapped.
                    print("Ok button tapped")
                    DispatchQueue.main.async
                        {
                            self.dismiss(animated: true, completion: nil)
                    }
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion:nil)
        }
    }
 

}
