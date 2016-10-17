//
//  WaitViewController.swift
//  carGO
//
//  Created by Vaishak iyer on 07/09/16.
//  Copyright © 2016 Vaishak iyer. All rights reserved.
//

import UIKit
import MapKit



class WaitViewController: UIViewController {
    
  
   
    @IBOutlet weak var totalWaiting: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
//    var mylocations = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        markPoints()

        // Do any additional setup after loading the view.
    }
    
//    func centerMap() {
//        let regionRadius: CLLocationDistance = 1000
//        var annotationCoord : CLLocationCoordinate2D = CLLocationCoordinate2D()
//        annotationCoord.latitude = (selectedLocation.latitude as NSString).doubleValue
//        annotationCoord.longitude = (selectedLocation.longitude as NSString).doubleValue
//        let coordinateRegion = MKCoordinateRegionMakeWithDistance(annotationCoord, regionRadius * 2.0, regionRadius * 2.0)
//        mapView.setRegion(coordinateRegion, animated: true)
//    }
    
    func markPoints() {
        
        
        
        var annotationCoord : CLLocationCoordinate2D = CLLocationCoordinate2D()
        annotationCoord.latitude = 12.9393434
        annotationCoord.longitude = 77.6705753
        
        let annotationPoint: MKPointAnnotation = MKPointAnnotation()
        annotationPoint.coordinate = annotationCoord
        annotationPoint.title = "Kadubeesinahalli"
        annotationPoint.subtitle = "Bangalore"
//        mapView.addAnnotation(annotationPoint)
        
        
        var annotationCoord1 : CLLocationCoordinate2D = CLLocationCoordinate2D()
        annotationCoord1.latitude = 12.9323434
        annotationCoord1.longitude = 77.6605753
        
        let AP: MKPointAnnotation = MKPointAnnotation()
        AP.coordinate = annotationCoord1
        AP.title = "marthahalli"
        AP.subtitle = "Bangalore"
//        mapView.addAnnotation(AP)
        
       
        
        
        var annotationCoord2 : CLLocationCoordinate2D = CLLocationCoordinate2D()
        annotationCoord2.latitude = 13.034622
        annotationCoord2.longitude = 77.5894184
        
        let APA: MKPointAnnotation = MKPointAnnotation()
        APA.coordinate = annotationCoord1
        APA.title = "Hebbal"
        APA.subtitle = "Bangalore"
       
        
         mapView.addAnnotations([annotationPoint, AP, APA])
        
        
    }
    
    func markRiderPoints( _ loc: String, lat: Float, long: Float , Subtitle: String)
    {
        
        
        let json = ["Location":"\(loc)","latitude":"\(lat)","Longitude":"\(long)","Subtitle":"\(Subtitle)" ] as Dictionary<String,String>
        
        
        //        let jsonData = try? NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
        
        // create post request
        let url = URL(string: "172.16.30.12:8080/Baba/rest/getios")!
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
                if let jsonDictionary = responseJSON, let success = jsonDictionary["status"] as? String{
                    
                    if success == "success"{
                        guard let userDictionary = jsonDictionary["data"] else{
                            return
                        }
                                                if let name = userDictionary["name"],
                                                    let latitude = userDictionary["latitude"],
                                                    //                        username = userDictionary["username"],
                                                    let longitude = userDictionary["longitude"],
                                                    let Subtitle = userDictionary["Subtitle"] {
                                                    let L = Location()
                                                    L.name = name as? String
                                                    L.latitude = latitude as? String
                                                    L.longitude = longitude as? String
                                                    L.subTitle = Subtitle as? String
                        
                        
                                                    //                            user.id = id as? Int
                        //                            if let token = userDictionary["token"] as? String{
                        //                                NSUserDefaults.standardUserDefaults().setValue(token, forKey: "Token")
                                                  }
                        
                                                    DispatchQueue.main.async(execute: {
                        //
                                                            var annotationCoord : CLLocationCoordinate2D = CLLocationCoordinate2D()
                                                            annotationCoord.latitude = Double(String(userDictionary["latitude"])) ?? 0.0
                                                            annotationCoord.longitude = Double(String(userDictionary["longitude"])) ?? 0.0 
                                                            
                                                            let annotationPoint: MKPointAnnotation = MKPointAnnotation()
                                                            annotationPoint.coordinate = annotationCoord
                                                            annotationPoint.title = "name"
                                                            annotationPoint.subtitle = "Subtitle"
                        //
                        //                                    
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
