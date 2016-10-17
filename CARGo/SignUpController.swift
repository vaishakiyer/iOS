//
//  SignUpController.swift
//  CARGo
//
//  Created by Vaishak iyer on 03/09/16.
//  Copyright © 2016 Vaishak iyer. All rights reserved.
//

import UIKit

class SignUpController: UIViewController {

    @IBOutlet var first_name: UITextField!
    @IBOutlet var last_name: UITextField!
    
    @IBOutlet var username: UITextField!
    
    @IBOutlet var email: UITextField!
    
    @IBOutlet var password: UITextField!
    
    
    @IBOutlet var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNavBar()
        

        // Do any additional setup after loading the view.
    }
    
    func addNavBar() {
        navigationItem.title = "Sign Up"
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Cancel", style: .plain, target: self, action: #selector(SignUpController.dissmissController))
    }
    
    func dissmissController() {
        dismiss(animated: true, completion: nil)
    }
    
    func isValidEmail(_ testStr:String?) -> Bool {
        if let str = testStr {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: str)
        }
        
        return false
    }
    func isValidPassword(_ testPwd:String?) -> Bool {
        if let str = testPwd {
            return (str.characters.count > 4)
        }
        
        return false
    }
    
    
    
    
    fileprivate func fieldsIsBlank() -> Bool {
        if (username.text == "" || password.text == "") {
            return true
        } else {
            return false
        }
        
    }

    
    
    @IBAction func signupButtonPressed(_ sender: AnyObject) {
//        
//        if fieldsIsBlank() {
//            displayAlert("Fill all the fields correctly!")
//        } else {
//            if let username = self.username.text, password = self.password.text {
//                makeLogInRequest(username, Password: password)
//            }
//            }
        
        if let firstName = self.first_name.text, let lastName = self.last_name.text,  let email = self.email.text, let username = self.username.text, let password = self.password.text{
            
            makeSignUpRequest(firstName, lastName: lastName, username: username, email: email, password: password)
            
            
        }

        
        
        
        
    }
    

        
        
        
        
    
        
        
    


            

            
            
            
//        func makeLogInRequest(username:String, Password:String)
//        {
//            
//         }
//

    
    
    
    func makeSignUpRequest(_ firstName: String, lastName:String, username:String, email:String, password:String)
    {
        
        let mapDict = ["first_name": "\(firstName)", "last_name": "\(lastName)", "username": "\(username)", "email": "\(email)", "password": "\(password)", "password_confirmation": "\(password)"]
        
        let json = ["user" : mapDict ]
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        
        // create post request
        let url = URL(string: "http://52.39.185.168:4001/login?auth=cherrywork")!
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // insert json data to the request
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data,response,error in
            
            if let responseJSON = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String:AnyObject]{
                print(responseJSON)
            }
            if let httpResponse = response as? HTTPURLResponse {
                switch(httpResponse.statusCode) {
                case 200: //success
                    print(httpResponse.statusCode)
                    DispatchQueue.main.async {
                     let controller = self.storyboard?.instantiateViewController(withIdentifier: String(ProfileViewController)) as! ProfileViewController
                        let nc = UINavigationController.init(rootViewController: controller)
                        
                        self.present(nc, animated: true, completion: nil)
                    }
                default:
                    print("GET Request unsuccessful. HTTP Status Code: \(httpResponse.statusCode)")
                    DispatchQueue.main.async {
                        self.displayAlert("Fill all the fields correctly!")
                    }
                }
            } else {
                print("Not a valid http response. NetworkOperation:downloadJSONFromURL()")
                DispatchQueue.main.async {
                    self.displayAlert("Server is down")
                }
            }
        })
        
        task.resume()
    }

        
        
        
        
        
        
    
    
    fileprivate func displayAlert(_ alert: String) {
        let alertView: UIAlertView = UIAlertView()
        alertView.title = "Sign Up Failed!"
        alertView.message = alert
        alertView.delegate = self
        alertView.addButton(withTitle: "OK")
        alertView.show()
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
