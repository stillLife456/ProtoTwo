//
//  JournalDetailViewController.swift
//  ProtoTwo
//
//  Created by Don on 2016-10-25.
//  Copyright © 2016 Don. All rights reserved.
//

import Foundation
import UIKit

class JournalDetailViewController: UIViewController, UINavigationControllerDelegate {


    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet var printButton: UIButton!


    var journalEntry: JournalEntry?

    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        
//        // Set up views if editing an existing Event.
//        if let journalEntry = journalEntry {
//            navigationItem.title = journalEntry.displayTime
//            timeLabel.text = journalEntry.feelingOne
//        }
        //timeLabel.text = "Check Yourself"
        let showStuff = journalEntry?.note
        timeLabel.text = showStuff
       // print(journalEntry?.displayTime)
        
      
      //  printButton.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func backPressed (sender: UIBarButtonItem){
        print("Pressed")
    
    }
    
    @IBAction func printPressed (sender: UIButton!) {
            print("AAAAAAAGGGHHHHHHH")
            print(journalEntry?.note)
            print(journalEntry!.latt)
            print(journalEntry!.long)
        
    
    }

}