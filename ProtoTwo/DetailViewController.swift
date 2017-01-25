//
//  DetailViewController.swift
//  ProtoTwo
//
//  Created by Don on 2016-07-04.
//  Copyright © 2016 Don. All rights reserved.
//

import Foundation
import UIKit
import EventKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //@IBOutlet weak var tableViewT: UITableView!
    @IBOutlet weak var tableViewT: UITableView!
    
    var dayEvents: [AnyObject] = []
    
    //this shoudn't be in here
    let calendar = NSCalendar.currentCalendar()
    
    
    let smokeYesImage = ImageBank.sharedInstance.smokingYes
    let smokeNoImage = ImageBank.sharedInstance.smokingNo
    let blankImage = ImageBank.sharedInstance.blankImage

    
    let green = UIColor.greenColor()
    let red = UIColor.redColor()
    let yellow = UIColor.yellowColor()
    let orange = UIColor.orangeColor()
    
    var passIndex = NSIndexPath()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewT?.delegate = self
        tableViewT?.dataSource = self
        
        
        tableViewT.registerNib(UINib(nibName: "CustomJournalCell", bundle: nil), forCellReuseIdentifier: "journalCell")
      
        
        }

    

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        var temp = 0
        
        if self.dayEvents.count == 0 {
            temp = 1
        }else{
            temp = self.dayEvents.count
        }
        
        return temp
    }
    
    //this shouldnt be in here
    func getJustHoursAndMinutes(date: NSDate)-> String {
        var hour = 0
        var minute = 0
       
        
            calendar.getHour(&hour, minute: &minute, second: nil, nanosecond: nil, fromDate: date)
            print("the hour is \(hour) and minute is \(minute)")

        let retString = "\(hour):\(minute)"
        
        return retString
        
        
        //        if #available(iOS 8.0, *) { }
    
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
//        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.Subtitle, reuseIdentifier:"cell")
        
//        let cell = tableView.dequeueReusableCellWithIdentifier("journalCell", forIndexPath: indexPath) as! CustomJournalCell
        
        let cell = tableView.dequeueReusableCellWithIdentifier("journalCell") as! CustomJournalCell
        
        if let jEntry = self.dayEvents[indexPath.row] as? JournalEntry{
            cell.feelingLabel.text = jEntry.feelingOne
            cell.cravingLabel.text = String(jEntry.cravingRating)
            cell.timeLabel.text = getJustHoursAndMinutes(jEntry.entryTime)
            
            cell.didSmokeImage.image = blankImage
            if let smokeBool = jEntry.didSmoke! as? Bool {
                if smokeBool{
                    cell.didSmokeImage.image = smokeYesImage
                    
                }else{
                    cell.didSmokeImage.image = smokeNoImage
                }
            
            }
            
            
        
        }
        
        
//        if dayEvents.count == 0 {
//            cell.textLabel!.text = "No Notes for this Day"
//            cell.imageView!.image = ImageBank.sharedInstance.nothingImage
//            
//        }else{
//           
//            //jjgjhgjh
//            if let event = self.dayEvents[indexPath.row] as? JournalEntry {
//            
//            
//            //let event = self.dayEvents[indexPath.row]
//            //print(event.hasNotes)
//            
//            if event.note != "" {
//                cell.detailTextLabel!.text = event.note
//            }else{
//               cell.detailTextLabel!.text = "No Notes"
//            }
//            //cell.detailTextLabel!.text = event.title
//            cell.textLabel!.text = event.feelingOne
//            
//            if event.didSmoke == false{
//                cell.imageView!.image = ImageBank.sharedInstance.goodWolfHead
//            } else if event.didSmoke == true{
//                cell.imageView!.image = ImageBank.sharedInstance.badWolfHead
//            }
//            
//            if event.quitDayFlag == true {
//                cell.imageView!.image = ImageBank.sharedInstance.quitDayImage   
//            }
//            switch (event.cravingRating){
//            case (0):
//                cell.backgroundColor = UIColor.whiteColor()
//            case (1):
//                cell.backgroundColor = green.colorWithAlphaComponent(0.5)
//            case (2):
//                cell.backgroundColor = yellow.colorWithAlphaComponent(0.5)
//            case (3):
//                cell.backgroundColor = orange.colorWithAlphaComponent(0.5)
//            case (4):
//                cell.backgroundColor = red.colorWithAlphaComponent(0.5)
//            case (5):
//                cell.backgroundColor = UIColor.redColor()
//            default:
//                cell.backgroundColor = UIColor.cyanColor()
//            
//            }
//                
//            }
//            
//            if let costBenEvent = self.dayEvents[indexPath.row] as? CostBenefitSheetModel {
//            
//              cell.textLabel?.text = String(costBenEvent.dateMade)
//            
//            }
//        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Selected")
        
        self.passIndex = indexPath
        //print(indexPath)
        //print(indexPath.row)
        
        if dayEvents.count != 0 {
    
        if let event = self.dayEvents[indexPath.row] as? JournalEntry{
        self.performSegueWithIdentifier("ShowJournalDetail", sender: self)
            print("Thought it was event")
            print(event.displayTime)
            print(event.entryTime)
        }
        
        if let costBen = self.dayEvents[indexPath.row] as? CostBenefitSheetModel{
            self.performSegueWithIdentifier("ShowCostBenSheet", sender: self)
            print("Thought it was costBen")
        }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
                if segue.identifier == "ShowJournalDetail" {
                    let journalDetailViewController = segue.destinationViewController as! JournalDetailViewController
        
                    // Get the cell that generated this segue.
                  //  if let selectedEventCell = sender as? UITableViewCell {
                        let indexPath = self.passIndex
                        let selectedEvent = dayEvents[indexPath.row] as? JournalEntry
                        journalDetailViewController.journalEntry = selectedEvent //as? JournalEntry
                        print(selectedEvent?.latt)
                    print("from detail \(selectedEvent?.displayTime)")
                   // }
                    presentViewController(journalDetailViewController, animated: false, completion: nil)
                }
                else if segue.identifier == "ShowCostBenSheet" {
                    print("show the sheet")
                    
                    let costBennySheetViewController = segue.destinationViewController as! CostBenefitTableViewController
                    //if let selectedEventCell = sender as? UITableViewCell {
                        let indexPath = self.passIndex
                        let selectedEvent = dayEvents[indexPath.row] as! CostBenefitSheetModel
                        print(selectedEvent.contents[0])
                        let passEvents = selectedEvent.contents //as! [DescriptionAndRating]
                        costBennySheetViewController.passedArray = passEvents //as! [DescriptionAndRating]
                        costBennySheetViewController.pastSheetFlag = true
                    //}
                    presentViewController(costBennySheetViewController, animated: false, completion: nil)
                }
                else if segue.identifier == "toJournalMap" {
                    let journalMapViewController = segue.destinationViewController as! JournalMapViewController
                    journalMapViewController.eventArray = sortEventsForMap(dayEvents)
                    //presentViewController(journalMapViewController, animated: false, completion: nil)
        }
            
        
    }
    
    func sortEventsForMap(array: [AnyObject]) -> [JournalEntry]{
        var tempArray = [JournalEntry]()
        
        for i in dayEvents {
            if i is JournalEntry{
                let temp = i as! JournalEntry
                tempArray.append(temp)
            }
            }
            return tempArray
        }
        
    
    
    
    @IBAction func prepareForUnwindToDetail(sender: UIStoryboardSegue) {
    }
    @IBAction func prepareForOtherUnwindToDetail(sender: UIStoryboardSegue) {
    }
    
}
