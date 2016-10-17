//
//  AcceptDeclineViewController.swift
//  CARGo
//
//  Created by Vaishak iyer on 26/09/16.
//  Copyright © 2016 Vaishak iyer. All rights reserved.
//

import UIKit

class AcceptDeclineViewController: UIViewController {
    
    var DeclineCompletionHandler:(() -> Void)!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func AcceptPressed(_ sender: AnyObject) {
        
        
       UserDefaults.standard.set(true, forKey: "Accept")
        UserDefaults.standard.synchronize()
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func DeclinePressed(_ sender: AnyObject) {
        
        if DeclineCompletionHandler != nil {
            DeclineCompletionHandler()
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
