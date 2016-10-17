//
//  RideDetailViewController.swift
//  CARGo
//
//  Created by Vaishak iyer on 04/09/16.
//  Copyright © 2016 Vaishak iyer. All rights reserved.
//

import UIKit

class RideDetailViewController: UIViewController {
    
    var DeclineCompletionHandler:(() -> Void)!
    
    @IBOutlet var MessageDisplayed: UITextView!
    
    var locations : [Location]!
    var locationString : String?
    var Rider : Ride?
    
    @IBOutlet var Locs: UILabel!
    
    @IBOutlet var pickuptime: UILabel!
    
    @IBOutlet var pickupLocation: UILabel!
    var Selected: Location?
    
    var a: String?
    var b: String?
    var c: String?
    var d: Bool?
    var e: String?
    func updateRide(){
        
        
        a =   UserDefaults.standard.value(forKey: "Enter the destination location") as? String
        
        
        b = UserDefaults.standard.value(forKey: "Enter the pickup location") as? String
        c =   UserDefaults.standard.value(forKey: "Enter the time") as? String
        
        
    }

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(false, forKey: "Accept")
        UserDefaults.standard.synchronize()
        
        addNavBar()
        
                initRideDisplay()
        
        updateRide()
        MessageDisplayed.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
       d = UserDefaults.standard.bool(forKey: "Accept")
        
        
        if d == true{
            
            MessageDisplayed.isHidden = false
            CanIRideWithYouPressed.isHidden = true
        }
            else
        {
            MessageDisplayed.isHidden = true
            CanIRideWithYouPressed.isHidden = false
        
        }
        
    }
        fileprivate func initRideDisplay() {
        
        pickuptime.text = c
        Locs.text = "Incture Technology"
        pickupLocation.text = a
    
    
    }
    func addNavBar() {
        navigationItem.title = "Ride Detail"
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Back", style: .plain, target: self, action: #selector( RideDetailViewController.dismiss))
    }
    
    func dismiss()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet var CanIRideWithYouPressed: UIButton!
    
    @IBAction func CanIRideWithYouPressed(_ sender: AnyObject) {
        
        
       
        
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: AcceptDeclineViewController)) as! AcceptDeclineViewController
        let nc = UINavigationController.init(rootViewController: controller)
        
        controller.DeclineCompletionHandler = {
            
            self.dismiss(animated: false, completion: nil)
            
            if self.DeclineCompletionHandler != nil {
                self.DeclineCompletionHandler()
            }
        }
        
        present(nc, animated: true, completion: nil)
        
//        var sourceDict = Dictionary<String,Dictionary<String,String>>()
//        
//        var innerDict = NSUserDefaults.standardUserDefaults().valueForKey("innerDict")  as? Dictionary<String,String>
//        
//        a = NSUserDefaults.standardUserDefaults().valueForKey("email") as? String
//        innerDict?["emailId"] = a
////        "emailId" : "divya.k@incture.com",
////        "rideId" : "RIDE04",
////        "source" : "Marathalli",
////        "destination" : "Incture",
////        "sourceLat" : "12.95053977",
////        "sourceLon" : "77.6990635",
////        "destLat" : "",
////        "date" :"2016-09-23",
////        "name" : "Ankit"
//       b = NSUserDefaults.standardUserDefaults().valueForKey("rideId") as? String
//        c = NSUserDefaults.standardUserDefaults().valueForKey("date") as? String
//        innerDict?["rideID"] = b
//        innerDict?["name"] = c
//     
//         d =   NSUserDefaults.standardUserDefaults().valueForKey("Enter the destination location") as? String
//        innerDict?["destination"] = d
//        
//        e =  NSUserDefaults.standardUserDefaults().valueForKey("source") as? String
//        innerDict?["source"] = e
//        
//        sourceDict["requestedCarDto"] = innerDict
//        
//        let json = sourceDict
//        
//        
//        //        let jsonData = try? NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
//        
//        // create post request
//        let url = NSURL(string: "http://172.16.30.12:8080/Baba/rest/requestride")!
//        let request = NSMutableURLRequest(URL: url)
//        let session = NSURLSession.sharedSession()
//        
//        request.HTTPMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        //        var err : NSError?
//        // insert json data to the request
//        do {
//            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(json, options: NSJSONWritingOptions(rawValue: 0))
//        }catch _{
//            print("error assigning httpBody")
//        }
//        
//        
//        
//        let task = session.dataTaskWithRequest(request){ data,response,error  -> Void in
//            
//            if let responseJSON = try? NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? [String:AnyObject]{
//                if let jsonDictionary = responseJSON, jsonDict = jsonDictionary["responseDto"] as? NSDictionary{
//                    // success
//                    guard let messageString = jsonDict["code"] as? Int else{
//                        print("Error:check message for status")
//                        return
//                    }
//                    
//                    if (messageString == 11){
//                        dispatch_async(dispatch_get_main_queue()
//                            , {
//                               let controller = self.storyboard?.instantiateViewControllerWithIdentifier(String(AcceptDeclineController)) as! AcceptDeclineController
//                                
//                                let nc = UINavigationController.init(rootViewController: controller)
//                                self.presentViewController(nc, animated: true, completion: nil)
//                                
//                                
//                                
//                        })
//                        
//                        
//                    }else{
//                        print("failure")
//                        dispatch_async(dispatch_get_main_queue()
//                            , {
//                        let alert = UIAlertController(title: "Alert", message: "ServerDown", preferredStyle: UIAlertControllerStyle.Alert)
//                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
//                        self.presentViewController(alert, animated: true, completion: nil)
//                        })
//                        
//                    }}else{
//                    print("service error")
//                }
//            }
//        }
//        task.resume()
        

        
        
        
        
        
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







