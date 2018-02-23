//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Emily Heejung Son on 2/22/18.
//  Copyright © 2018 Emily Heejung Son. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBAction func LoginAction(_ sender: Any) {
       
        if let text = UsernameTextField.text {
            if ( text.isEmpty ) {
                displayAlert()
                return
            }
        }
        if let text = PasswordTextField.text {
            if ( text.isEmpty ) {
                displayAlert()
                return
            }
        }
            
        let username = UsernameTextField.text ?? ""
        let password = PasswordTextField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
                let alertController = UIAlertController(title: "Login Failed", message: "Username and/or password are incorrect", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                // add the cancel action to the alertController
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion: nil)
                
            } else {
                print("User logged in successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)

                // display view controller that needs to shown after successful login
            }
        }
        
    }
    
    func displayAlert() {
        let alertController = UIAlertController(title: "Login Failed", message: "Please fill all required fields", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
       
        // add the cancel action to the alertController
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)

        
    }
    
    
    
    @IBAction func SignUpAction(_ sender: Any) {
     
        
        // set user properties
        if let text = UsernameTextField.text {
            if ( text.isEmpty ) {
                displayAlert()
                return
            }
        }
        if let text = PasswordTextField.text {
            if ( text.isEmpty ) {
                displayAlert()
                return
            }
        }
        let newUser = PFUser()
        
      
        
        newUser.username = UsernameTextField.text!

        newUser.password = PasswordTextField.text!
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                let alertController = UIAlertController(title: "Sign up Failed", message: "Sign up failed", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                // add the cancel action to the alertController
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion: nil)
            } else {
                print("User Registered successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)

                // manually segue to logged in view
            }
        }
    
    }
    
    @IBOutlet weak var UsernameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
