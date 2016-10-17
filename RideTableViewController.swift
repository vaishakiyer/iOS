//
//  RideTableViewController.swift
//  CARGo
//
//  Created by Vaishak iyer on 03/09/16.
//  Copyright © 2016 Vaishak iyer. All rights reserved.
//

import UIKit
import MapKit

class RideTableViewController: UIViewController, AddRideControllerDelegate, CLLocationManagerDelegate, MKMapViewDelegate{
    
    var rides = [Ride]()
    
    var newRide : Ride?
    var a : String?
    var b : String?
    var c : String?
    var d: String?
    var e : String?
    var f: String?
    var g: String?
    var h: String?
    
    var selectedLocation: Location!
    
    var locationManager: CLLocationManager!
    var seenError: Bool = false
    var locationFixAchieved : Bool = false
    var locationStatus : NSString = "Not Started"
    var coordinate: CLLocationCoordinate2D!
  //  var myLocations: [CLLocation] = []

    
    @IBOutlet var theMap: MKMapView!
    
    @IBOutlet weak var desLocation: UILabel!
    
    @IBOutlet weak var pickUpTime: UILabel!
    
    @IBOutlet weak var pickUpLocation: UILabel!
    
    func updateRide() {
    
    a =   UserDefaults.standard.value(forKey: "Enter the  destinationa location") as? String
        
        
    b = UserDefaults.standard.value(forKey: "Enter the pickup location") as? String
    c =   UserDefaults.standard.value(forKey: "Enter the time") as? String
    d = UserDefaults.standard.value(forKey: "Source") as? String
        if let innerDict = UserDefaults.standard.value(forKey: "innerDict") as? Dictionary<String, AnyObject> {
            
            e = innerDict["sourceLat"] as? String
            f = innerDict["sourceLon"] as? String
            
        }
        
        g = UserDefaults.standard.value(forKey: "name") as? String
        

        

        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
              let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: RideDetailViewController)) as! RideDetailViewController
        controller.Selected = selectedLocation
        controller.DeclineCompletionHandler = {
            self.dismiss(animated: false, completion: nil)
        }
        
        let nc = UINavigationController.init(rootViewController: controller)
        present(nc, animated: true, completion: nil)
        
        
    }
    
    func loadSampeRides() {
        rides.append(Ride(id:rides.count, location: "Incture Technology", pickupLocation: "marthahalli bridge", time: "8:20AM"))
        rides.append(Ride(id:rides.count, location: "Incture Technology", pickupLocation: "Hebbal", time: "10:20AM"))
        rides.append(Ride(id:rides.count, location: "Incture Technology", pickupLocation: "Kundalhalli", time: "12:20PM"))
      
        if let newRide = self.newRide {
            
            
         rides.append(newRide)

        
        }
    }
    
    func initlocationmanager()
    {
        
        seenError = true
        locationFixAchieved = false
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Request permission to the user
        locationManager.requestAlwaysAuthorization()
        
        theMap.delegate = self
     //   theMap.mapType = MKMapType.Hybrid
        theMap.showsUserLocation = true
        
        
    }
    
    //getting the location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      
        if( locationFixAchieved == false)
        {
            locationFixAchieved = true
            
            let locationArray = locations as NSArray
            let locationObj = locationArray.lastObject as! CLLocation
            
            self.coordinate = locationObj.coordinate
            print(self.coordinate.latitude)
            print(self.coordinate.longitude)
           
            
            


            

        }
        
        
        
    }
    func centerMap() {
        let regionRadius: CLLocationDistance = 1000
        var annotationCoord : CLLocationCoordinate2D = CLLocationCoordinate2D()
        annotationCoord.latitude = (selectedLocation.latitude as NSString).doubleValue
        annotationCoord.longitude = (selectedLocation.longitude as NSString).doubleValue
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(annotationCoord, regionRadius * 2.0, regionRadius * 2.0)
        theMap.setRegion(coordinateRegion, animated: true)
    }
    
    func markPoints() {
        var annotationCoord : CLLocationCoordinate2D = CLLocationCoordinate2D()
        annotationCoord.latitude = (selectedLocation.latitude as NSString).doubleValue
        annotationCoord.longitude = (selectedLocation.longitude as NSString).doubleValue
        
        let annotationPoint: MKPointAnnotation = MKPointAnnotation()
        annotationPoint.coordinate = annotationCoord
        annotationPoint.title = selectedLocation.name
        annotationPoint.subtitle = "Anand: 7348858742"
        theMap.addAnnotation(annotationPoint)
    }

    func updateMap() {
        if e != nil && f != nil && d != nil && g != nil {
            
            centerMap()
            markPoints()
        }
    }
    
    func createcell(){
        
        desLocation.text = "Incture Technology"
        pickUpTime.text = c
        pickUpLocation.text = "Hebbal"
        
        
        
        
        
        
        
    }
    
    
    
    
        
        
        
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       loadSampeRides()
        configureNavBar()
        
        if (selectedLocation != nil)
        {
        markPoints()
        centerMap()
        }
        
        initlocationmanager()
        
        
      //  tableView.registerClass(RideTableViewCell.self, forCellReuseIdentifier: String(RideTableViewCell))
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func viewWillAppear(_ animated: Bool) {
        updateRide()
        createcell()
//        updateMap()
    }
    
    func configureNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(self.addARide))
    }
    
    func addARide() {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: AddRideViewController)) as! AddRideViewController
        let nc = UINavigationController.init(rootViewController: controller)
        present(nc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    

    // MARK: - Table view data source

   

//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//    
//
//        let cellIdentifier = "RideTableViewCell"
//        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RideTableViewCell
////       let cell = tableView.dequeueReusableCellWithIdentifier(String(RideTableViewCell), forIndexPath: indexPath) as! RideTableViewCell
//         let R = rides[indexPath.row]
//        if let ridesArray = rides as [Ride]? {
//      cell.createCell(ridesArray[indexPath.row])
//        }
//        
//
//        return cell
//    }
    
    
    
    
    
    
    
    
    
 //   

    
    

    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
