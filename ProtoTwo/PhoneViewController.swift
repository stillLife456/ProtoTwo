//
//  PhoneViewController.swift
//  ProtoTwo
//
//  Created by Don on 2016-11-29.
//  Copyright © 2016 Don. All rights reserved.
//

import Foundation
import UIKit



class PhoneViewController: UIViewController {

    
    let myNumber = 6044463961
    
    
    @IBOutlet weak var phoneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
    }
    
    @IBAction func call(sender: UIButton) {
    print("Call em up!")

        if let phoneCallURL:NSURL = NSURL(string: "tel://\(myNumber)") {
            let application:UIApplication = UIApplication.sharedApplication()
            if (application.canOpenURL(phoneCallURL)) {
                application.openURL(phoneCallURL);
            }
        }
        
    
    }
    

}
