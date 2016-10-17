//
//  CarViewController.swift
//  carGO
//
//  Created by Vaishak iyer on 07/09/16.
//  Copyright © 2016 Vaishak iyer. All rights reserved.
//

import UIKit





class CarViewController: UIViewController {
    
    
    

    @IBOutlet var CarModel: UITextField!

    @IBOutlet var driverName: UITextField!
    
    @IBOutlet var licenceNumber: UITextField!
    
    @IBOutlet var noOfSeats: UITextField!
    
    @IBOutlet var licencePlate: UITextField!
    var A : String?
    var B: String?
    var C: String?
    var D: String?
    var E: String?
    var car : [Detail]!
    var editButton = UIBarButtonItem()
    
    
    
    
    
    
    
    func updateItem(){
        
        A = UserDefaults.standard.value(forKey: "model") as? String
        B = UserDefaults.standard.value(forKey: "NAME") as? String
        C = UserDefaults.standard.value(forKey: "licenseNo") as? String
        D = UserDefaults.standard.value(forKey: "seats") as? String
        E = UserDefaults.standard.value(forKey: "licenseNo") as? String
        
        CarModel.text = A
        driverName.text = B
        licenceNumber.text = C
        noOfSeats.text = D
        licencePlate.text = E
        
    }
   
    
    func navigation()
 {
    
    
    navigationItem.title = ""
    navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Cancel", style: .plain, target: self, action: #selector(CarViewController.dismissController))
   
   navigationItem.title = ""
  
    editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(CarViewController.editPressed))
    navigationItem.rightBarButtonItems = [editButton]
    }
    
    func editPressed(){
        
        CarModel.text = ""
        driverName.text = ""
        licencePlate.text = ""
        noOfSeats.text = ""
        licenceNumber.text = ""
        
    
        
    
    
    }
    
    func isEditEnabled()
    {
        
        
//        let A = CarModel.text
//        let B = driverName.tag
//        let C = licenceNumber.tag
//        let D = noOfSeats.tag
//        let E = licencePlate.tag
    
        if let carDetail = car as [Detail]! {
            
        editButton.isEnabled = false
        
        }
        else {
            editButton.isEnabled = true
        }
        
        
        
    
    }

    func dismissController()  {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func SubmitPressed(_ sender: AnyObject) {
        
        let model = CarModel.text
        let Name = driverName.text
        
        if ( model!.isEmpty  || Name!.isEmpty)
        {
            displayMyAlertMessage("Fill the fields")
            
            
            
        }
        else
        {
            if let  NAME = self.driverName.text, let MODEL = self.CarModel.text{
                Proceed(NAME, model:MODEL )
                
            }
        }
//   , LN = self.licenceNumber.text , SEATS = self.noOfSeats.text, LP = self.licencePlate.text
     
        
//    ,LN: LN1,SEATS: SEATS1, LP: LP1    
        
//     , LN: String, SEATS: String, LP: String   
        
    }
    
    func displayMyAlertMessage(_ usermessage: String?){
        
        
        
        let myAlert = UIAlertController(title: "ALert", message: "Enter the Required Elements", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil )
        
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion : nil)
    }
    
    func Proceed(_ name: String, model: String )
{
    let sourceDict = ["emailId":"\(name)","model":"\(model)"] as Dictionary<String,String>
    
//    ,"licenseNo":"\(LN)","seats":"\(SEATS)","regNo":"\(LP)"
    
   let json = ["vehicleDetailDto": sourceDict]
    
//    for Credential in car{
//        
//        innerDict["model"] = Credential.model
//        innerDict["regNo"] = Credential.licensePlate
//        innerDict["seats"] = Credential.seats
//        innerDict["licenseNo"] = Credential.licenseNo
//        innerDict["emailId"] = Credential.driver
//        
//        //                A = (NSUserDefaults.standardUserDefaults().valueForKey("email") as? String)!
//        //
//        //                innerDict["emailId"] = A
//        
//        NSUserDefaults.standardUserDefaults().setObject(Credential.model, forKey: "model")
//        NSUserDefaults.standardUserDefaults().setObject(Credential.licensePlate, forKey: "licensePlate")
//        NSUserDefaults.standardUserDefaults().setObject(Credential.seats, forKey: "seats")
//        NSUserDefaults.standardUserDefaults().setObject(Credential.licenseNo, forKey: "licenseNo")
//        NSUserDefaults.standardUserDefaults().setObject(Credential.driver, forKey: "NAME")
//        NSUserDefaults.standardUserDefaults().synchronize()
    
        
        
        
        
        
        
        
//    }
//    
//    sourceDict["vehicleDetailDto"] = innerDict
//    
//    let json = sourceDict
    
    //        let jsonData = try? NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
    
    // create post request
    let url = URL(string: "http://172.16.30.12:8080/Baba/rest/registervehicle")!
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
                guard let messageString = success["message"] as? String else{
                    print("Error:check message for status")
                    return
                }
                
                if messageString == "Success" {
                    
                    DispatchQueue.main.async(execute: {
                            
                            
                            let control = self.storyboard?.instantiateViewController(withIdentifier: String(WaitViewController)) as! WaitViewController
                            
                            self.navigationController?.pushViewController(control, animated: true)
                            
                            
                            
                            
                    })
                    
                }else{
                    print("Failure")
                    
                    let myAlert = UIAlertController(title: "ALert", message: "Failed to process", preferredStyle: UIAlertControllerStyle.alert)
                    
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil )
                    
                    myAlert.addAction(okAction)
                    self.present(myAlert, animated: true, completion : nil)
                    
                    
                }
            }
        }
        
    })
    task.resume()
    
    

    
    
    }
    
    
    
    
    
    
    
   
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigation()
        Next.isEnabled = true
//      loadFunc(<#T##Name: String##String#>, Model: <#T##Int#>, LNumber: <#T##Int#>, LPlate: <#T##Int#>, Seats: <#T##Int#>)
        isEditEnabled()
        updateItem()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var Next: UIButton!
    
    
    @IBAction func nextButtonPressed(_ sender: AnyObject) {
        
        
        let control = self.storyboard?.instantiateViewController(withIdentifier: String(describing: WaitViewController)) as! WaitViewController
        
        navigationController?.pushViewController(control, animated: true)
        
        
        
        
    }
    
    func buttonEnable(){
        
        Next.isEnabled = true
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
