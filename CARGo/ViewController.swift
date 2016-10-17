//
//  ViewController.swift
//  CARGo
//
//  Created by Vaishak iyer on 03/09/16.
//  Copyright © 2016 Vaishak iyer. All rights reserved.
//

import UIKit
var user:  User!
var is_active = false



class ViewController: UIViewController {

    @IBOutlet var username: UITextField!
    @IBOutlet var Password: UITextField!
    
    
    @IBOutlet var loginButton: UIButton!
    
    @IBOutlet var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        username.layer.cornerRadius = 8.0
        username.layer.borderColor = UIColor.white.cgColor
        username.layer.borderWidth = 1.0
        username.clipsToBounds = true
        
        Password.layer.cornerRadius = 8.0
        Password.layer.borderColor = UIColor.white.cgColor
        Password.layer.borderWidth = 1.0
        Password.clipsToBounds = true
        
        loginButton.layer.cornerRadius = 8.0
        signupButton.layer.cornerRadius = 8.0
        
        
        let strUsernamePlaceholder = NSAttributedString(string: "username", attributes: [NSForegroundColorAttributeName:UIColor.white])
        username.attributedPlaceholder = strUsernamePlaceholder
        
        let strPasswordPlaceholder = NSAttributedString(string: "password", attributes: [NSForegroundColorAttributeName:UIColor.white])
    
        Password.attributedPlaceholder = strPasswordPlaceholder
        
        
    
    }
   
    fileprivate func fieldsIsBlank() -> Bool {
        if (username.text == "" || Password.text == "") {
            return true
        } else {
            return false
        }
        
    }


    
    
    
    
    
    
    
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        
        if fieldsIsBlank() {
            displayAlert("Fill all the fields correctly!")
        } else {
            if let username = self.username.text, let password = self.Password.text {
                makeLogInRequest(username, Password: password)
            }
        }

    }
    
    
    
    
    
    
    
    
        
    

    
    
    func makeLogInRequest(_ username:String, Password:String)
    {
        
    }

    
    
    
    
   
    
    
    
    
   func displayAlert(_ alert: String) {
        let alert = UIAlertController(title: "Alert", message: alert, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "logInSegue") {
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
















