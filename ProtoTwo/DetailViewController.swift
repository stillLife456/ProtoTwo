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
    
    @IBOutlet weak var tableViewT: UITableView!

    @IBOutlet weak var navBar: UINavigationBar!
    
    var dayEvents: [AnyObject] = []
    
    //this shoudn't be in here
    let calendar = NSCalendar.currentCalendar()
    
    
    let smokeYesImage = ImageBank.sharedInstance.smokingYes
    let smokeNoImage = ImageBank.sharedInstance.smokingNo
    let blankImage = ImageBank.sharedInstance.blankImage
    let nothingImage = ImageBank.sharedInstance.nothingImage
    let shrugImage = ImageBank.sharedInstance.shrug

    
    let green = UIColor.greenColor()
    let red = UIColor.redColor()
    let yellow = UIColor.yellowColor()
    let orange = UIColor.orangeColor()
    
    let cellId:String = "CustomJournalCell"
    
    var passIndex = NSIndexPath()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewT?.delegate = self
        tableViewT?.dataSource = self
        
        
        tableViewT.registerNib(UINib(nibName: "CustomJournalCell", bundle: nil), forCellReuseIdentifier: "CustomJournalCell")
        
        if dayEvents.count != 0 {
        let temp = dayEvents[0] as! JournalEntry
        let title = getJustDayAndMonth(temp.entryTime)
      
        self.navBar.topItem!.title = title
        }else {
            self.navBar.topItem!.title = "No Entries on this Day"
        }
        
        //self.navBar.topItem!.title = "Hey Does this Work?"
        }
    
    func getJustDayAndMonth(date: NSDate)-> String {
        var retString = ""
        
        
        let formatter:NSDateFormatter = NSDateFormatter()
        let formatterTwo:NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "EEEE, MMMM "
        let tempString = formatter.stringFromDate(date)
        
        
        formatterTwo.dateFormat = "DD"
        let tempTwo = Int(formatterTwo.stringFromDate(date))
        let suffixString = addSuffix(toNumber: tempTwo!)
        
        
        
//        let myComponents = calendar.components(.Weekday, fromDate: date)
//        let weekDay = String(myComponents.weekday)
      
        
        
        
        
        
        retString = tempString + suffixString
        

        
        
//        calendar.getHour(&hour, minute: &minute, second: nil, nanosecond: nil, fromDate: date)
//        print("the hour is \(hour) and minute is \(minute)")
//        
//        let retString = "\(hour):\(minute)"
        
        return retString
        
        
        //        if #available(iOS 8.0, *) { }
        
    }

    
    //StackOverflow
    func addSuffix(toNumber number: Int) -> String {
        var suffix: String
        let ones: Int = number % 10
        let tens: Int = (number / 10) % 10
        if tens == 1 {
            suffix = "th"
        }
        else if ones == 1 {
            suffix = "st"
        }
        else if ones == 2 {
            suffix = "nd"
        }
        else if ones == 3 {
            suffix = "rd"
        }
        else {
            suffix = "th"
        }
        
        var completeAsString: String = "\(number)\(suffix)"
        return completeAsString
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
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CustomJournalCell", forIndexPath: indexPath) as! CustomJournalCell
        
//        let cell = tableView.dequeueReusableCellWithIdentifier("CustomJournalCell") as! CustomJournalCell
        if dayEvents.count != 0 {
        if let jEntry = self.dayEvents[indexPath.row] as? JournalEntry{
            cell.feelingLabel.text = jEntry.feelingOne
            cell.cravingLabel.text = "Craving: \(jEntry.cravingRating)"
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
        }else{
            cell.feelingLabel.text = ""
            cell.cravingLabel.text = ""
            cell.timeLabel.text = ""
            cell.didSmokeImage.image = shrugImage
            cell.disclosureButton.hidden = true
        
        }
        
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
