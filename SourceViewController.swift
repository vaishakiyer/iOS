//
//  SourceViewController.swift
//  CARGo
//
//  Created by Vaishak iyer on 23/09/16.
//  Copyright © 2016 Vaishak iyer. All rights reserved.
//

import UIKit

class SourceViewController: UIViewController,  UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var sourcePicker: UIPickerView!
    
    @IBOutlet var daySegment: UISegmentedControl!
    @IBOutlet var datePick: UIDatePicker!
    var today = true
    var time: String?
    var locationString : String?
    var locations : [Location]!
    var selectedIndex: Int = 0

    
    
    @IBAction func datePick(_ sender: AnyObject) {
        
        
        let index = daySegment.selectedSegmentIndex
        today = index == 0
        if today {
            datePick.datePickerMode = .time
            let currentDate = Date()
            datePick.date = currentDate
            datePick.minuteInterval = 5
        }
        else{
            datePick.datePickerMode = .dateAndTime
            datePick.minuteInterval = 5
        }
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        time = timeFormatter.string(from: sender.date)

        
        
    }
    
    func addNavBar() {
        navigationItem.title = "Sign Up"
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Cancel", style: .plain, target: self, action: #selector(SignUpController.dissmissController))
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        createLocations()
        daySegment.selectedSegmentIndex = 0
        sourcePicker.dataSource = self
        sourcePicker.delegate = self
        let currentDate = Date()
        datePick.minimumDate = currentDate
         addNavBar()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createLocations() {
        let loc1 = Location()
        loc1.name = "Kadubeesanahalli"
        loc1.subTitle = "Bangalore"
        loc1.latitude = "12.9393434"
        loc1.longitude = "77.6705753"
        
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

    
    @IBAction func SubmitPressed(_ sender: AnyObject) {
//        
//        let controller = self.storyboard?.instantiateViewControllerWithIdentifier(String(CarViewController )) as! CarViewController
//        
//        navigationController?.pushViewController(controller, animated: true)
//        if (locations.isEmpty ) {
//            let alert = UIAlertController(title: "Alert", message: "Fill all the fields!", preferredStyle: UIAlertControllerStyle.Alert)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
//            self.presentViewController(alert, animated: true, completion: nil)
//        } else {
//            //            self.performSegueWithIdentifier("submitAddRideSegue", sender: self)
//        }
//        //        delegate?.updateRide()
//        
//        NSUserDefaults.standardUserDefaults().setValue(locationString, forKey: "Enter the pickup location")
//        NSUserDefaults.standardUserDefaults().setValue(time, forKey: "Enter the time")
//        
//        NSUserDefaults.standardUserDefaults().synchronize()
       
        
        var sourceDict = Dictionary<String,Dictionary<String,String>>()
        
        var innerDict = Dictionary<String,String>()
        
        for location in locations{
            if location.name == locationString{
                innerDict["sourceLat"] = location.latitude
                innerDict["sourceLon"] = location.longitude
                
            }
        }
        UserDefaults.standard.setValue(innerDict, forKey: "innerDict")
        UserDefaults.standard.synchronize()
        
        sourceDict["sourceDto"] = innerDict
        
        let json = sourceDict
        
        
        //        let jsonData = try? NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
        
        // create post request
        let url = URL(string: "http://172.16.30.12:8080/Baba/rest/readavailable")!
        let request = NSMutableURLRequest(url: url)
        let session = URLSession.shared
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //        var err : NSError?
        // insert json data to the request
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions(rawValue: 0))
        }catch _{
            print("error assigning httpBody")
        }
        
        
        
        let task = session.dataTask(with: request, completionHandler: { data,response,error  -> Void in
            
            if let responseJSON = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String:AnyObject]{
                if let jsonDictionary = responseJSON, let jsonDictArray = jsonDictionary["offeredRideDto"] as? [NSDictionary]{
                    // success
                    if jsonDictArray.count == 0{
                        DispatchQueue.main.async(execute: {
                                let alert = UIAlertController(title: "Alert", message: "No Passengers in this vicinity", preferredStyle: UIAlertControllerStyle.alert)
                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                                
                        })
                        
                        
                    }else{
                        print("success")
                        let A = jsonDictArray[0]
                        
                        let B = A["source"]
                        let C = A["sourceLat"]
                        let D = A["sourceLon"]
                        let E = A["mobileNumber"]
                        let F = A["name"]
                        
                        UserDefaults.standard.setValue(B, forKey: "Source")
                        UserDefaults.standard.setValue( C, forKey: "sourceLat")
                        UserDefaults.standard.setValue(D, forKey: "sourceLon")
                        UserDefaults.standard.setValue(E, forKey: "mobileNumber")
                        UserDefaults.standard.setValue(F, forKey: "name")
                        
                        
                        UserDefaults.standard.synchronize()
                        DispatchQueue.main.async(execute: {
                                
                                let controller = self.storyboard?.instantiateViewController(withIdentifier: String(CarViewController )) as! CarViewController
                             self.navigationController?.pushViewController(controller, animated: true)

                                //
                                //        navigationController?.pushViewController(controller, animated: true)
                                
                                
                        })
                        
                        
                        
                        
                    }}else{
                    print("service error")
                }
            }
        })
        task.resume()
        
 
        
        
        
        
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
