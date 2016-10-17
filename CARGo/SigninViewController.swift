//
//  SigninViewController.swift
//  carGO
//
//  Created by Vaishak iyer on 06/09/16.
//  Copyright © 2016 Vaishak iyer. All rights reserved.
//

import UIKit


class SigninViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBAction func logInButtonPressed(_ sender: AnyObject) {
       
        
        
        
        isValidEmail("valid email")
        isValidPassword("valid Password")
        
        
        let enterUserName = username.text
        let enterPassword = password.text
        
        if ( enterUserName!.isEmpty  || enterPassword!.isEmpty)
        {
            displayMyAlertMessage("Enter Username and Password")
            
            
            
        }
        else
         {
                if let username = self.username.text, let password = self.password.text {
                    makeLogInRequest(username, Password: password)
                }
            }
    }
   
            
//          let controller = self.storyboard?.instantiateViewControllerWithIdentifier(String(ProfileViewController)) as! ProfileViewController
//            let nc = UINavigationController.init(rootViewController: controller)
//            presentViewController(nc, animated: true, completion: nil)

            
        

    
    @IBAction func signUpButtonPressed(_ sender: AnyObject) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: SignUpController)) as! SignUpController
        let nc = UINavigationController.init(rootViewController: controller)
        present(nc, animated: true, completion: nil)
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
    

    
    
    @IBOutlet weak var signUpButtonPressed: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func displayMyAlertMessage(_ usermessage: String?){
        
        
        
        let myAlert = UIAlertController(title: "ALert", message: usermessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil )
        
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion : nil)
        
        
        
    }
    
    func makeLogInRequest(_ username:String, Password:String)
    {
        
        
        let sourceDict = ["emailId":"\(username)","password":"\(Password)"] as Dictionary<String,String>
        let json = ["loginDto": sourceDict]
        
        UserDefaults.standard.setValue(username, forKey: "email")
        
        
//        let jsonData = try? NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
        
        // create post request
        let url = URL(string: "http://172.16.30.12:8080/Baba/rest/login")!
        let request = NSMutableURLRequest(url: url)
        let session = URLSession.shared
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
//        var err : NSError?
        // insert json data to the request
         do {
         request.httpBody = try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions(rawValue: 0))
         }catch _{
            print("error assigning httpBody")
        }
        

        
        let task = session.dataTask(with: request, completionHandler: { data,response,error  -> Void in
            
            if let responseJSON = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String:AnyObject]{
                if let jsonDictionary = responseJSON, let success = jsonDictionary["responseDto"] as? NSDictionary{
                    guard let message = success["message"] as? String else{
                        print("Error:check message for status")
                        return
                    }
                    if message == "Success"{
//                        guard let userDictionary = jsonDictionary["data"] else{
//                            return
//                        }
//                        if let fname = userDictionary["firstName"],
//                            lname = userDictionary["lastName"],
//                            //                        username = userDictionary["username"],
//                            email = userDictionary["email"],
//                            id = userDictionary["_id"] {
//                            user = User(fname: fname as! String, lname: lname as! String, username: "", email: email as! String)
//                            user.id = id as? Int
//                            if let token = userDictionary["token"] as? String{
//                            NSUserDefaults.standardUserDefaults().setValue(token, forKey: "Token")
//                            }
                        

                            
                    
                            DispatchQueue.main.async(execute: {
                                    let controller = self.storyboard?.instantiateViewController(withIdentifier: String(ProfileViewController)) as! ProfileViewController
                                    
                                    
                                    let nc = UINavigationController.init(rootViewController: controller)
                                    self.present(nc, animated: true, completion: nil)
                            })
                      
                        
                    }else{
                        print("Login Failure")
                        
                    }
                }
            }
        })
        task.resume()
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
