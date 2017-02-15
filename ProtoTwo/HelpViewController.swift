//
//  HelpViewController.swift
//  ProtoTwo
//
//  Created by Don on 2016-08-18.
//  Copyright © 2016 Don. All rights reserved.
//

import Foundation
import UIKit

class HelpViewController: UITableViewController {
    
    
    @IBOutlet weak var breatheButton: UIButton!
    @IBOutlet weak var waitButton: UIButton!
    @IBOutlet weak var thinkButton: UIButton!
    @IBOutlet weak var talkButton: UIButton!
    @IBOutlet weak var lookButton: UIButton!
 
    @IBOutlet weak var photoButton: UIButton!

    
//    @IBAction func doTheThing() {
//        print("Do the thing")
//        let mainVC = CostBenefitSheet()
//       // mainVC.delegate = self
//        mainVC.modalPresentationStyle = .OverCurrentContext
//        presentViewController(mainVC, animated: false, completion: nil)
//    }
    
    @IBAction func prepareForUnwindToHelp(sender: UIStoryboardSegue) {
    }
    
}

