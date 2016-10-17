//
//  ProfileViewController.swift
//  CARGo
//
//  Created by Vaishak iyer on 03/09/16.
//  Copyright © 2016 Vaishak iyer. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController{
   

    @IBOutlet var name: UILabel!
    @IBOutlet var username: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updatename()
        navigationItem.title = "Profile"
        // Do any additional setup after loading the view.
    }
    
    func updatename()
    {
        name.text = "Divya"
        username.text = "Divya.k@incture.com"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func GetaRidePressed(_ sender: AnyObject) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: RideTableViewController)) as! RideTableViewController
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    @IBAction func OfferaRide(_ sender: AnyObject) {
        let Control = self.storyboard?.instantiateViewController(withIdentifier: String(describing: SourceViewController)) as! SourceViewController
        
        let nc = UINavigationController.init(rootViewController: Control)
        present(nc, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func logOutPressed(_ sender: AnyObject) {
//        let Con = self.storyboard?.instantiateViewControllerWithIdentifier(String(SigninViewController)) as! SigninViewController
//        navigationController?.popToViewController( Con, animated: true)
        
       self.dismiss(animated: true, completion: nil)
        
        
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
