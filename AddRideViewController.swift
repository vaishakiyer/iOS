//
//  AddRideViewController.swift
//  CARGo
//
//  Created by Vaishak iyer on 03/09/16.
//  Copyright © 2016 Vaishak iyer. All rights reserved.
//

import UIKit

protocol AddRideControllerDelegate {
    func updateRide()
}

class AddRideViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var location: UITextField!
    
    @IBOutlet weak var timepicker: UIDatePicker!
    
    @IBOutlet weak var pickupLocationpicker: UIPickerView!
    
    @IBOutlet weak var daySegment: UIPickerView!
    
    var today = true
    var locationString : String?
    var time : String?
    var locations : [Location]!
    var selectedIndex: Int = 0
    
    
    
    var delegate = AddRideControllerDelegate?()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createLocations()
        segment.selectedSegmentIndex = 0
        pickupLocationpicker.dataSource = self
        pickupLocationpicker.delegate = self
        let currentDate = Date()
        timepicker.minimumDate = currentDate
        addNavBar()
        location.text = "Incture Technology"

        // Do any additional setup after loading the view.
    }
    
    func createLocations() {
        let loc1 = Location()
        loc1.name = "Kadubeesanahalli"
        loc1.subTitle = "Bangalore"
        loc1.latitude = "12.95053977"
        loc1.longitude = "77.6990635"
//        loc1.latitude = "12.97053977"
//        loc1.longitude = "77.5990635"
        
        let loc2 = Location()
        loc2.name = "Marathahalli"
        loc2.subTitle = "Bangalore"
        loc2.latitude = "12.9323434"
        loc2.longitude = "77.6605753"
        
        let loc3 = Location()
        loc3.name = "Hebbal"
        loc3.subTitle = "Bangalore"
        loc3.latitude = "13.034622"
        loc3.longitude = "77.5894184"
        
        let loc4 = Location()
        loc4.name = "HSR Layout"
        loc4.subTitle = "Bangalore"
        loc4.latitude = "12.91025779"
        loc4.longitude = "77.6281508"
        
        let loc5 = Location()
        loc5.name = "BTM layout"
        loc5.subTitle = "Bangalore"
        loc5.latitude = "12.9135223"
        loc5.longitude = "77.6038353"
        
        let loc6 = Location()
        loc6.name = "Koramangala"
        loc6.subTitle = "Bangalore"
        loc6.latitude = "12.9354504"
        loc6.longitude = "77.6146828"
        
        let loc7 = Location()
        loc7.name = "Incture Technologies"
        loc7.subTitle = "Bangalore"
        loc7.latitude = "12.9362629"
        loc7.longitude = "77.6888162"
        
        let loc8 = Location()
        loc8.name = "MG Road"
        loc8.subTitle = "Bangalore"
        loc8.latitude = "12.9737554"
        loc8.longitude = "77.6074368"
        
        let loc9 = Location()
        loc9.name = "Brookfield"
        loc9.subTitle = "Bangalore"
        loc9.latitude = "12.9669473"
        loc9.longitude = "77.7110167"
        
        let loc10 = Location()
        loc10.name = "whitefield"
        loc10.subTitle = "Bangalore"
        loc10.latitude = "12.9646836"
        loc10.longitude = "77.7191899"
        
        locations = [loc1, loc2, loc3, loc4 , loc5, loc6, loc7, loc8, loc9, loc10]
        
        
    }
    
    
    func addNavBar() {
        navigationItem.title = "AddRideControl"
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Cancel", style: .plain, target: self, action: #selector(self.dismiss))
        
        
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Submit", style: .plain, target: self, action: #selector(self.loadthepage))
    
    }
    
    func dismiss(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadthepage()
    {
        
//        let controller = self.storyboard?.instantiateViewControllerWithIdentifier(String(RideTableViewController)) as! RideTableViewController
//        controller.selectedLocation = locations[selectedIndex]
//        navigationController?.pushViewController(controller, animated: true)
//        if (location.text == "") {
//            let alert = UIAlertController(title: "Alert", message: "Fill all the fields!", preferredStyle: UIAlertControllerStyle.Alert)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
//            self.presentViewController(alert, animated: true, completion: nil)
//        } else {
////            self.performSegueWithIdentifier("submitAddRideSegue", sender: self)
//        }
//        delegate?.updateRide()
        UserDefaults.standard.setValue(location.text, forKey: "Enter the destination Location")
        UserDefaults.standard.setValue(locationString, forKey: "Enter the pickup location")
        UserDefaults.standard.setValue(time, forKey: "Enter the time")
        UserDefaults.standard.synchronize()
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: RideTableViewController)) as! RideTableViewController
        controller.selectedLocation = locations[selectedIndex]
        
          navigationController?.pushViewController(controller, animated: true)
        
      
        
//        { "sourceDto":{ "sourceLat" : "12.97053977","sourceLon" : "77.5990635"}}
        
//        var sourceDict = Dictionary<String,Dictionary<String,String>>()
//        
//        var innerDict = Dictionary<String,String>()
//        
//        for location in locations{
//            if location.name == locationString{
//                 innerDict["sourceLat"] = location.latitude
//                 innerDict["sourceLon"] = location.longitude
//                
//            }
//        }
//            NSUserDefaults.standardUserDefaults().setValue(innerDict, forKey: "innerDict")
//          NSUserDefaults.standardUserDefaults().synchronize()
//        
//        sourceDict["sourceDto"] = innerDict
//        
//        let json = sourceDict
//        
//        
//        //        let jsonData = try? NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
//        
//        // create post request
//        let url = NSURL(string: "http://172.16.30.12:8080/Baba/rest/readavailable")!
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
//                if let jsonDictionary = responseJSON, jsonDictArray = jsonDictionary["offeredRideDto"] as? [NSDictionary]{
//                    // success
//                    if jsonDictArray.count == 0{
//                        dispatch_async(dispatch_get_main_queue()
//                            , {
//                                let alert = UIAlertController(title: "Alert", message: "No rides offered", preferredStyle: UIAlertControllerStyle.Alert)
//                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
//                                self.presentViewController(alert, animated: true, completion: nil)
//        
//                        })
//                    
//                
//                    }else{
//                       print("success")
//                        let A = jsonDictArray[0]
//                        
//                        let B = A["source"]
//                        let C = A["sourceLat"]
//                        let D = A["sourceLon"]
//                        let E = A["mobileNumber"]
//                        let F = A["name"]
//                        let rideId = A["rideId"]
//                        let date = A["date"]
//                        
//                        
//                        NSUserDefaults.standardUserDefaults().setValue(B, forKey: "Source")
//                                NSUserDefaults.standardUserDefaults().setValue( C, forKey: "sourceLat")
//                                NSUserDefaults.standardUserDefaults().setValue(D, forKey: "sourceLon")
//                           NSUserDefaults.standardUserDefaults().setValue(E, forKey: "mobileNumber")
//                        NSUserDefaults.standardUserDefaults().setValue(F, forKey: "name")
//                            NSUserDefaults.standardUserDefaults().setValue(rideId, forKey: "rideId")
//                            NSUserDefaults.standardUserDefaults().setValue(date, forKey: "date")
//                        
//                        
//                        
//                                NSUserDefaults.standardUserDefaults().synchronize()
//                    dispatch_async(dispatch_get_main_queue()
//                        , {
//                            
//                            self.dismissViewControllerAnimated(true, completion: {});
//                            
//                            
//                        })
//                        
//                        
//                        
//                        
//                    }}else{
//                    print("service error")
//                }
//            }
//        }
//        task.resume()
        
// 
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var segment: UISegmentedControl!
  
    
    
    @IBAction func rideData(_ sender: AnyObject) {
        
        let index = segment.selectedSegmentIndex
        today = index == 0
        if today {
            timepicker.datePickerMode = .time
            let currentDate = Date()
            timepicker.date = currentDate
            timepicker.minuteInterval = 5
        }
        else{
            timepicker.datePickerMode = .dateAndTime
            timepicker.minuteInterval = 5
        }
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        time = timeFormatter.string(from: sender.date)
    }

    

func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
}

func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return locations.count
}

func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return  locations[row].name
}

func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    locationString = locations[row].name
    selectedIndex = row
}
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        if segue.identifier == "submitAddRideSegue" {
//            let navigationViewController = segue.destinationViewController as! UINavigationController
//            let destinationViewController = navigationViewController.viewControllers.first as! RideTableViewController
//            
//            let dateFormatter = NSDateFormatter()
//            dateFormatter.dateFormat = "HH:mm"
//            let strDate = dateFormatter.stringFromDate(timepicker.date)
//            
//            let strPickupLocation = LocationData[pickupLocationpicker.selectedRowInComponent(0)]
//            destinationViewController.newRide = Ride(id: destinationViewController.rides.count, location: location.text!, pickupLocation: strPickupLocation, time: strDate)
//        }
//    }
//   
    
    
    
    
    

    

}




    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


