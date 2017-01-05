//
//  NotificationTableViewController.swift
//  ProtoTwo
//
//  Created by Don on 2016-07-21.
//  Copyright © 2016 Don. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

let kSavedItemsKey = "savedItems"
let categoryName = "FIRST_CATEGORY"
//let categoryName = "FEED_THE_WOLF"



class NotificationTableViewController: UITableViewController, AddNotificationsTableViewControllerDelegate, CLLocationManagerDelegate  {
    
    var notifications  = [Notification]()
    let locationManager = CLLocationManager()
    
    private let calendar = NSCalendar.currentCalendar()
    private var dateComponents = NSDateComponents()
    private var dateFormatter = NSDateFormatter()
    
    private var timedNotifications = [Notification]()
    private var gpsNotifications = [Notification]()
    private var timedAndGPSNotification = [Notification]()
    
    var alertController = UIAlertController(title: "Really?", message: "Do you really want to delete this notification?", preferredStyle: .Alert)
    // I tried conneting this from story board but had errors. may indicate probelm
    // @IBOutlet var tableView: UITableView!
    
    
    
    
    //Damn I'm good! Need to clean this up
    var sloppyUUID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        loadAllNotifications()
        print(" Notifications count/////////////////////")
        print(notifications.count)
        printAllStroredTimeNotes()
        printAllStoredLocations()
        sortNotificationTypes()
        
        setUpAlertController()
        //clearAllOldNotifications()
        
        //trying to refresh??
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    //Print all timed notification stored in Core Data
    func printAllStroredTimeNotes(){
        var count = 0
        print("from the time core:")
        for temp in UIApplication.sharedApplication().scheduledLocalNotifications! {
            count += 1
            print("Count is \(count)")
            print(temp.alertBody)
            
        }
    }
    
    func printAllStoredLocations(){
        var count = 0
        print("from the location core:")
        for region in locationManager.monitoredRegions {
            count += 1
            print("Count is \(count)")
            print(region.identifier)
            
        }
    }
    
    func sortNotificationTypes(){
        

        
        for notification in notifications {
            if notification.timeNotifiOn && !notification.gpsNotifiOn {
                timedNotifications.append(notification)
            } else if !notification.timeNotifiOn && notification.gpsNotifiOn {
                gpsNotifications.append(notification)
            } else if notification.timeNotifiOn && notification.gpsNotifiOn {
                timedAndGPSNotification.append(notification)
            } else {
                timedNotifications.append(notification)
            }
        }
    }
    
    func getNotifForMapView() -> [Notification]{
        var tempArray = [Notification]()
        
        for n in gpsNotifications {
            tempArray.append(n)
        }
        for n in timedAndGPSNotification {
            tempArray.append(n)
        }
        return tempArray
    }
    
    func clearAllOldNotifications(){
        for temp in UIApplication.sharedApplication().scheduledLocalNotifications! {
            UIApplication.sharedApplication().cancelLocalNotification(temp)
        }
        loadAllNotifications()

    }
    
    func setUpAlertController(){
        // Create the actions
        let deleteAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            self.deleteCurrentNotification(self.sloppyUUID)
            //print("Delete Pressed")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            //print("Cancel Pressed")
        }
        
        // Add the actions
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
    }
    
    func deleteCurrentNotification(uuidToDelete: String){
      
        
        for n in notifications {
            if n.identifier == uuidToDelete{
                let index = notifications.indexOf(n)
                print("Deleting from Array: \(n.note)")
                if n.timeNotifiOn{
                    stopMonitoringTime(n)
                }
                if n.gpsNotifiOn{
                    stopMonitoringLocation(n)
                }
                
                notifications.removeAtIndex(index!)
            }
            
        }
        

       
        updateTableView()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let tempNotif = notifications[indexPath.row]
        
        
        self.sloppyUUID = tempNotif.identifier
        print(tempNotif.note)
        print(sloppyUUID)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Timed Notification"
        } else if section == 1 {
            return "GPS Notification"
        } else {
            return "Timed & GPS Notification"
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return timedNotifications.count
        } else if section == 1 {
            return gpsNotifications.count
        } else if section == 2 {
            return timedAndGPSNotification.count
        }
        return notifications.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("Timecell", forIndexPath: indexPath) as! TimeTableViewCell
            let notification = timedNotifications[indexPath.row]
            cell.titleLable.text = notification.title
            print("Making Cel For \(notification.title)")
            cell.timeLabel.text = format(notification.time)
            cell.weekdayLabel.text = formatWeekdays(notification.weekdays)
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("GPScell", forIndexPath: indexPath) as! GPSTableViewCell
            let notification = gpsNotifications[indexPath.row]
            
            cell.titleLabel.text = notification.title
            print("Making Cel For \(notification.title)")
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("T&Gcell", forIndexPath: indexPath) as! TimeAndGPSTableViewCell
            let notification = timedAndGPSNotification[indexPath.row]
            cell.titleLabel.text = notification.title
            cell.timeLabel.text = format(notification.time)
            print("Making Cel For \(notification.title)")
            cell.weekdayLabel.text = formatWeekdays(notification.weekdays)
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 77
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addNotification" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let vc = navigationController.viewControllers.first as! AddNotificationTableViewController
            vc.delegate = self
        }
        
        if(segue.identifier == "toMapViewController") {
            
            let mapViewController = (segue.destinationViewController as! GPSNotificationMapViewController)
            
            
            mapViewController.notificationArray = getNotifForMapView()
        }
    }
    

    ///bryan thinks these are being called unneccesarrily
    func loadAllNotifications() {
        // notifications = []
        
        if let savedItems = NSUserDefaults.standardUserDefaults().arrayForKey(kSavedItemsKey) {
            for savedItem in savedItems {
                if let notification = NSKeyedUnarchiver.unarchiveObjectWithData(savedItem as! NSData) as? Notification {
                    addNotification(notification)
                }
            }
        }
    }
    
    func saveAllNotifications() {
        let items = NSMutableArray()
        for notification in notifications {
            let item = NSKeyedArchiver.archivedDataWithRootObject(notification)
            items.addObject(item)
        }
        NSUserDefaults.standardUserDefaults().setObject(items, forKey: kSavedItemsKey)
        NSUserDefaults.standardUserDefaults().synchronize()
        
       
    }
    
    // MARK: Functions that update the model/associated views with geotification changes
    
    func addNotification(notification: Notification) {
        notifications.append(notification)
        
        
        
        
    }

    
    func startMonitoringLocation(notification: Notification) {
        
        // Make sure device is capable of monitoring location
        if !CLLocationManager.isMonitoringAvailableForClass(CLCircularRegion) {
            
            // Don
            //                showSimpleAlertWithTitle("Error", message: "Geofencing is not supported on this device!", viewController: self)
            print("Cant Monitor")
            return
        }
        // Make sure app is authorized to monitor user location
        if CLLocationManager.authorizationStatus() != .AuthorizedAlways {
            print("Not Authorized")
            // Don
            //            showSimpleAlertWithTitle("Warning", message: "Your geotification is saved but will only be activated once you grant Geotify permission to access the device location.", viewController: self)
        }
        
        // Create region for notification
        let region = regionWithNotification(notification)
        // Tell Core Location to monitor this location
        locationManager.startMonitoringForRegion(region)
        print("started monitoring \(region.identifier)")
    }
    
    // Tell Core Location to stop monitoring this location because deleted
    func stopMonitoringLocation(notification: Notification) {
        for region in locationManager.monitoredRegions {
            if let circularRegion = region as? CLCircularRegion {
                if circularRegion.identifier == notification.identifier {
                    locationManager.stopMonitoringForRegion(circularRegion)
                }
            }
        }
    }
    
    func startMonitoringTime(notification:Notification) {
        let localNotification = UILocalNotification()
        let times = notification.addTimes(notification.time, weekdays: notification.weekdays)
        print("Start montioring for \(notification.note)")
        
        //Stuff that happens either way
        localNotification.category = categoryName
        localNotification.alertBody = notification.note
        localNotification.userInfo = ["UUID": notification.identifier]
        
        if notification.everydayOn {
            localNotification.fireDate = notification.time
            localNotification.repeatInterval = .Day
            
            print(notification.time)
        } else {
            for temp in times {
                localNotification.fireDate = temp
                localNotification.repeatInterval = .Weekday
            }
        }
        notification.singleTimedNotification.append(localNotification)
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        print("Should have been added")
        
    }
    
    func stopMonitoringTime(notification:Notification) {
        
        for temp in UIApplication.sharedApplication().scheduledLocalNotifications! {
            if temp.category == categoryName {
                let tempDict = temp.userInfo! as NSDictionary
                let uid = tempDict["UUID"]! as! String
                if uid == notification.identifier {
                    //Cancelling local notification
                    UIApplication.sharedApplication().cancelLocalNotification(temp)
                    print("Deleting FROM CORE!!!! \(notification.note)")
                    
                }
            }
            
        }
        
    }
    
    func regionWithNotification(notification: Notification) -> CLCircularRegion {
        // Initialize CLCircularRegion with geofence values
        let region = CLCircularRegion(center: notification.coordinate, radius: notification.radius, identifier: notification.identifier)
        // Determine if notification comes on entrance or exit
        region.notifyOnEntry = (notification.eventType == .OnEntry)
        region.notifyOnExit = !region.notifyOnEntry
        return region
    }
    
    // MARK: AddGeotificationViewControllerDelegate
    
    func addNotificationTableViewController(controller: AddNotificationTableViewController, didAddCoordinate coordinate: CLLocationCoordinate2D, radius: Double, identifier: String, note: String, eventType: EventType, time:NSDate, weekdays:[Weekday], everydayOn:Bool, timedNotifiOn:Bool, gpsNotifiOn:Bool) {
        controller.dismissViewControllerAnimated(true, completion: nil)
        
        // Make sure radius is within parameters for monitoring
        let clampedRadius = (radius > locationManager.maximumRegionMonitoringDistance) ? locationManager.maximumRegionMonitoringDistance : radius
        
        let notification = Notification(coordinate: coordinate, radius: clampedRadius, identifier: identifier, note: note, eventType: eventType, time: time, weekdays: weekdays, everydayOn: everydayOn, timedNotifiOn: timedNotifiOn, gpsNotifiOn: gpsNotifiOn)
        addNotification(notification)
        
        if notification.timeNotifiOn {
            startMonitoringTime(notification)
        }
        if notification.gpsNotifiOn {
            startMonitoringLocation(notification)
        }
        
    
        
        
        updateTableView()
    }
    
    func updateTableView(){
       
        ///bryan thinks these are being called unneccesarrily
        saveAllNotifications()
        print("Array Count: \(notifications.count)")
        
        notifications.removeAll()
        timedNotifications.removeAll()
        gpsNotifications.removeAll()
        timedAndGPSNotification.removeAll()// because of repeats
        
        loadAllNotifications()
        print("Array Count: \(notifications.count)")
        sortNotificationTypes()
        print("Time: \(timedNotifications.count)")
        print("GPS: \(gpsNotifications.count)")
        print("TimeGPS: \(timedAndGPSNotification.count)")
        
        self.tableView.reloadData()
        
        self.tableView.beginUpdates()
        
        self.tableView.endUpdates()
        // self.tableView.reloadData()
    }
    
    func format(time : NSDate) -> String{
        dateFormatter.dateFormat = "h:mm a"
        let convertedString = dateFormatter.stringFromDate(time)
        return convertedString
    }
    
    func formatWeekdays(weekdays:[Weekday]) -> String{
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
    @IBAction func prepareForUnwind(sender: UIStoryboardSegue) {
    }
}