//
//  AddNotificationTableViewController.swift
//  ProtoTwo
//
//  Created by 田中早紀 on 2016-07-21.
//  Copyright © 2016 Don. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

protocol AddNotificationsTableViewControllerDelegate {
    func addNotificationTableViewController(controller: AddNotificationTableViewController, didAddCoordinate coordinate: CLLocationCoordinate2D,radius: Double, identifier: String, note: String, eventType: EventType, time:NSDate, weekdays:[Weekday], everydayOn:Bool, timedNotifiOn:Bool, gpsNotifiOn:Bool)
}

class AddNotificationTableViewController:UITableViewController, UITextFieldDelegate, MKMapViewDelegate, CLLocationManagerDelegate {
    
    //MARK: Properties
    
    // Visibility bools
    var timedNotificationVisible:Bool!
    var gpsNotificationVisible:Bool!
    
    var datePickerVisible:Bool!
    var weekdaysVisible:Bool!
    
    //View Controller Outlets
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var eventTypeSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var radiusTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextField! //Message Body
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var daysLabel: UILabel!
    
    //    var radiusTextFilled:Bool!
    //    var noteTextFilled:Bool!
    
    
    let numberToolbar: UIToolbar = UIToolbar()
    
    @IBOutlet var checkImages: [UIImageView]!
    var weekdays = [Weekday]()
    
    private let calendar = NSCalendar.currentCalendar()
    private var dateComponents = NSDateComponents()
    private var dateFormatter = NSDateFormatter()
    private var time = NSDate()
    
    // Saki Edited
    private var timedNotificationOn:Bool!
    private var gpsNotificationOn:Bool!
    
    private var defaultCellHeight:CGFloat = 44
    
    //Notification properties
    let locationManager = CLLocationManager()
    
    var delegate: AddNotificationsTableViewControllerDelegate!
    
    private var everydayOn :Bool!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = saveButton
        saveButton.enabled = false
        
        //add done to number pad
        numberToolbar.barStyle = UIBarStyle.BlackTranslucent
        numberToolbar.items=[
            UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(cancelKeyboard)),
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Apply", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(applyKeyboard))
        ]
        numberToolbar.sizeToFit()
        radiusTextField.inputAccessoryView = numberToolbar
        
        radiusTextField.delegate = self
        radiusTextField.keyboardType = UIKeyboardType.NumberPad
        noteTextField.delegate = self
        titleTextField.delegate = self
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        
        for temp in 0...6 {
            let weekday = Weekday(checkBool: true, weekdayNum: temp)
            weekdays.append(weekday)
        }
        
        //        noteTextFilled = false
        //        radiusTextFilled = false
        
        // Saki Edited
        timedNotificationOn = false
        gpsNotificationOn = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //timeLabel.text = format(datePicker.date)
        
        datePickerVisible = false
        weekdaysVisible = false
        timedNotificationVisible = false
        everydayOn = false
        
        gpsNotificationVisible = false
        
    }
    
    //Dismiss keyboard on return
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed
    {
        textField.resignFirstResponder()
        return true
    }
    
    //This is the meat of this particular burger
    @IBAction private func onSave(sender: AnyObject) {
        
        let identifier = NSUUID().UUIDString
        
        //TODO:
        //let title = titleTextField.text! as NSString
        
        //Location Information to be saves
        let coordinate = mapView.centerCoordinate
        let radius = (radiusTextField.text! as NSString).doubleValue
        let note = noteTextField.text
        let eventType = (eventTypeSegmentedControl.selectedSegmentIndex == 0) ? EventType.OnEntry : EventType.OnExit
        
        // TODO: (Saki) Timer Information to be saved
        everydayOn = true
        for weekday in weekdays {
            if !weekday.checkBool {
                everydayOn = false
            }
        }
        
        print("saved")
        
        delegate!.addNotificationTableViewController(self, didAddCoordinate: coordinate, radius: radius, identifier: identifier, note: note!, eventType: eventType, time: time, weekdays: weekdays, everydayOn: everydayOn, timedNotifiOn: timedNotificationOn, gpsNotifiOn: gpsNotificationOn)
    }
    
    //Location Manager Set Up Stuff
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        mapView.showsUserLocation = (status == .AuthorizedAlways)
        
    }
    
    
    //Funcs for number keyboard toolbar Behaviour
    func applyKeyboard () {
        radiusTextField.resignFirstResponder()
    }
    
    func cancelKeyboard () {
        radiusTextField.text=""
        radiusTextField.resignFirstResponder()
    }
    
    
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
            
        }
        return true
    }
    @IBAction func textFieldEditingChanged(sender: UITextField) {
        if !gpsNotificationOn && timedNotificationOn {
            saveButton.enabled = !(noteTextField.text!.isEmpty)
        } else if (gpsNotificationOn && timedNotificationOn) || (gpsNotificationOn && !timedNotificationOn) {
            saveButton.enabled = !(radiusTextField.text!.isEmpty) && !(noteTextField.text!.isEmpty) && !((titleTextField.text?.isEmpty)!)
        }
        print("Is this thing on?")
    }
    
    
    
    @IBAction func datePicked(sender: UIDatePicker) {
        time = sender.date
        timeLabel.text = format(sender.date)
    }
    
    @IBAction func timeSwitchOn(sender: UISwitch) {
        if sender.on{
            showTimedNotification()
            roundTime()
            timeLabel.text = format(time)
            if !timedNotificationOn {
                timedNotificationOn = true
            }
        } else {
            hideTimedNotification()
            hideWeekdaysCells()
            if timedNotificationOn! {
                timedNotificationOn = false
            }
        }
    }
    
    @IBAction func gpsSwitchOn(sender: UISwitch) {
        if sender.on {
            showGPSNotification()
            hideDatePickerCell(ContainingDatePicker: datePicker)
            hideWeekdaysCells()
            if !gpsNotificationOn {
                gpsNotificationOn = true
            }
        } else {
            hideGPSNotification()
            if gpsNotificationOn! {
                gpsNotificationOn = false
            }
        }
    }
    
    
    //Func to test if zoom is working
    @IBAction func zoomPressed(sender: UIButton){
        zoomToUserLocationInMapView(mapView)
        print("ZOOM PRESSED")
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else if section == 1 {
            return 11
        } else {
            return 4
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            switch indexPath.row {
            case 1:
                // Collapse
                if weekdaysVisible! {
                    hideWeekdaysCells()
                }
                
                // Expand
                if datePickerVisible! {
                    hideDatePickerCell(ContainingDatePicker: datePicker)
                } else {
                    showDatePickerCell(containingDatePicker: datePicker)
                }
                
            case 3:
                if datePickerVisible! {
                    hideDatePickerCell(ContainingDatePicker: datePicker)
                }
                
                if weekdaysVisible! {
                    hideWeekdaysCells()
                } else {
                    showWeekdaysCells()
                }
                
            case 4...10:
                let index = indexPath.row - 4
                if weekdays[index].checkBool! {
                    hideCheckImage(index)
                } else {
                    showCheckImage(index)
                }
                
            default:
                break
            }
        }
        
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height:CGFloat = defaultCellHeight
        
        if indexPath.section == 1 {
            switch indexPath.row {
                
            case 1:
                if let time = timedNotificationVisible {
                    height = time ? defaultCellHeight : 0
                }
                
            case 2:
                if let datePickerVisible = datePickerVisible {
                    height = datePickerVisible ? 216 : 0
                }
                
            case 3:
                if let time = timedNotificationVisible {
                    height = time ? defaultCellHeight : 0
                }
                
            case 4...11:
                if let weekdays = weekdaysVisible {
                    height = weekdays ? defaultCellHeight : 0
                }
                
            default:
                break
            }
        }
        
        if indexPath.section == 2 {
            if let temp = gpsNotificationVisible {
                if indexPath.row == 1 {
                    height = temp ? 380 : 0
                } else if indexPath.row == 2 || indexPath.row == 3{
                    height = temp ? defaultCellHeight : 0
                }
            }
        }
        return height
    }
    
    // Show & Hide Timed Notification section
    func showTimedNotification() {
        timedNotificationVisible = true
        updateTableView()
    }
    
    func hideTimedNotification() {
        timedNotificationVisible = false
        updateTableView()
    }
    
    func showGPSNotification() {
        gpsNotificationVisible = true
        updateTableView()
        zoomToUserLocationInMapView(mapView)
    }
    
    func hideGPSNotification() {
        gpsNotificationVisible = false
        updateTableView()
    }
    
    // DatePicker - show and hide functions
    func showDatePickerCell(containingDatePicker picker:UIDatePicker){
        if picker ==  datePicker {
            datePickerVisible = true
        }
        
        updateTableView()
    }
    
    func hideDatePickerCell (ContainingDatePicker picker:UIDatePicker) {
        if picker == datePicker {
            datePickerVisible = false
        }
        
        updateTableView()
    }
    
    // Show & Hide weekday cells
    func showWeekdaysCells() {
        weekdaysVisible = true
        
        updateTableView()
    }
    
    func hideWeekdaysCells() {
        weekdaysVisible = false
        daysLabel.text = formatWeekdays()
        
        updateTableView()
    }
    
    func showCheckImage (index:Int) {
        weekdays[index].checkBool = true
        checkImages[index].hidden = false
        daysLabel.text = formatWeekdays()
        
        updateTableView()
    }
    
    func hideCheckImage (index:Int) {
        weekdays[index].checkBool = false
        checkImages[index].hidden = true
        daysLabel.text = formatWeekdays()
        
        updateTableView()
    }
    
    func updateTableView() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func format(time : NSDate) -> String{
        dateFormatter.dateFormat = "h:mm a"
        let convertedString = dateFormatter.stringFromDate(time)
        return convertedString
    }
    
    func formatWeekdays() -> String{
        var weekdayStr = [String]()
        var count = 0
        for temp in weekdays {
            if temp.checkBool! {
                weekdayStr.append(temp.nameOfWeek)
            }
            count += 1
        }
        
        if weekdayStr.isEmpty {
            return "None"
        } else if weekdayStr.count == 7 {
            return "Everyday"
        } else {
            return weekdayStr.joinWithSeparator(", ") /////////////////////////////////////////String I Want
        }
    }
    
    func roundTime() {
        dateComponents = calendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day,NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Weekday], fromDate: time)
        if dateComponents.minute % 10 != 0 {
            let minute = dateComponents.minute
            let newMinute = minute - (minute % 10)
            dateComponents.minute = newMinute
        }
        time = calendar.dateFromComponents(dateComponents)!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


