//
//  CalendarViewController.swift
//  ProtoTwo
//
//  Created by Don on 2016-07-04.
//  Copyright © 2016 Don. All rights reserved.
//

import Foundation
import UIKit
import JTAppleCalendar

class PickQuitDayViewController: UIViewController, UIGestureRecognizerDelegate {
    
    let testCalendar: NSCalendar! = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
    var passCellDate = NSDate()
    
    @IBOutlet weak var quitDayButton: UIButton!
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    let formatter = NSDateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.calendarView.dataSource = self
        self.calendarView.delegate = self
        self.calendarView.registerCellViewXib(fileName: "CellView")
        
        let tempDate = NSDate()
        calendarView.scrollToDate(tempDate, triggerScrollToDateDelegate: true)
        
        calendarView.backgroundColor = UIColor.blackColor()
        calendarView.cellInset = CGPoint(x: 1, y: 1)
        
        
        
    }
    
    
    func getJournalEntriesForDay() -> [JournalEntry]{
        var successCount = 0
        var failureCount = 0
        var passEvents : [JournalEntry] = []
        
        for e in Journal.sharedInstance.journalArray {
            if testCalendar.isDate(e.entryTime, inSameDayAsDate : passCellDate){
                if e.title == "success"{
                    successCount += 1
                    
                }else if e.title == "failure"{
                    failureCount += 1
                }
                
                passEvents.append(e)
                
            }
        }
        return passEvents
    }
    
    @IBAction func quitDayButtonPressed(sender: UIButton){
        print("Quit!!!!")
    }
    
    
    func setupViewsOfCalendar(startDate: NSDate, endDate: NSDate) {
        
        let month = testCalendar.component(NSCalendarUnit.Month, fromDate: startDate)
        let monthName = NSDateFormatter().monthSymbols[(month-1) % 12] // 0 indexed array
        let year = NSCalendar.currentCalendar().component(NSCalendarUnit.Year, fromDate: startDate)
        self.title = monthName + " " + String(year)
    }
    // Prepare detaiViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "Show Detail"{
            
            let detailViewController = segue.destinationViewController as! DetailViewController
            let displayEvents = getJournalEntriesForDay()
            
            //pass stuff over
            detailViewController.dayEvents = displayEvents
            
            
        }
    }
    
    
    @IBAction func prepareForUnwind(sender: UIStoryboardSegue) {
    }
    
    
    
}









extension PickQuitDayViewController: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate  {
    
    func configureCalendar(calendar: JTAppleCalendarView) -> (startDate: NSDate, endDate: NSDate, numberOfRows: Int,   calendar: NSCalendar) {
        
        // You can set your date using NSDate() or NSDateFormatter. Your choice.
        let firstDate = getStartAndEndDates(-6)
        let secondDate = getStartAndEndDates(6)
        let numberOfRows = 6
        let aCalendar = testCalendar // Properly configure your calendar to your time zone here
        return (startDate: firstDate, endDate: secondDate, numberOfRows: numberOfRows, calendar: aCalendar)
    }
    
    func getStartAndEndDates(offset: Int) -> NSDate{
        let newDate = testCalendar.dateByAddingUnit(.Month, value: offset, toDate: NSDate(), options: [])
        return newDate!
    }
    
    func calendar(calendar: JTAppleCalendarView, isAboutToDisplayCell cell: JTAppleDayCellView, date: NSDate, cellState: CellState) {
        
        (cell as! CellView).setupCellBeforeDisplay(cellState, date: date)
        
    }
    func calendar(calendar: JTAppleCalendarView, didDeselectDate date: NSDate, cell: JTAppleDayCellView?, cellState: CellState) {
        (cell as? CellView)?.cellSelectionChanged(cellState)
    }
    
    func calendar(calendar: JTAppleCalendarView, didSelectDate date: NSDate, cell: JTAppleDayCellView?, cellState: CellState) {
        (cell as? CellView)?.cellSelectionChanged(cellState)
        
        passCellDate = cellState.date
        self.performSegueWithIdentifier("Show Detail", sender: self)
        //printSelectedDates(cellState)
    }
    
    
    func calendar(calendar: JTAppleCalendarView, didScrollToDateSegmentStartingWithdate startDate: NSDate, endingWithDate endDate: NSDate) {
        setupViewsOfCalendar(startDate, endDate: endDate)
    }
    
    func calendar(calendar: JTAppleCalendarView, sectionHeaderIdentifierForDate date: (startDate: NSDate, endDate: NSDate)) -> String? {
        //let comp = testCalendar.component(.Month, fromDate: date.startDate)
        //if comp % 2 > 0{
        //  return "WhiteSectionHeaderView"
        //}
        return "PinkSectionHeaderView"
    }
    
    func calendar(calendar: JTAppleCalendarView, sectionHeaderSizeForDate date: (startDate: NSDate, endDate: NSDate)) -> CGSize {
        if testCalendar.component(.Month, fromDate: date.startDate) % 2 == 1 {
            return CGSize(width: 200, height: 50)
        } else {
            return CGSize(width: 200, height: 100) // Yes you can have different size headers
        }
    }
    
    func calendar(calendar: JTAppleCalendarView, isAboutToDisplaySectionHeader header: JTAppleHeaderView, date: (startDate: NSDate, endDate: NSDate), identifier: String) {
        //switch identifier {
        //case "WhiteSectionHeaderView":
        //  let headerCell = (header as? WhiteSectionHeaderView)
        // headerCell?.title.text = "Design multiple headers"
        //default:
        // let headerCell = (header as? PinkSectionHeaderView)
        // headerCell?.title.text = headerText
        //}
    }
    
    
}