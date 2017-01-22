//
//  AppDelegate.swift
//  ProtoTwo
//
//  Created by Don on 2016-07-01.
//  Copyright © 2016 Don. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {
    
    var window: UIWindow?
    var storyboard:UIStoryboard?
    let locationManager = CLLocationManager()
    // array for check regions
    var regionArray = [CLCircularRegion]()
    
    var alert = AlertHelper()
    
    func application(application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.Portrait
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Action A
        let firstAction:UIMutableUserNotificationAction = UIMutableUserNotificationAction()
        firstAction.identifier = "RESIST_ACTION"
        firstAction.title = "Resist"
        
        firstAction.activationMode = UIUserNotificationActivationMode.Background
        firstAction.destructive = false
        firstAction.authenticationRequired = false
        
        // Action B
        let secondAction:UIMutableUserNotificationAction = UIMutableUserNotificationAction()
        secondAction.identifier = "SLIP_ACTION"
        secondAction.title = "Slip"
        
        secondAction.activationMode = UIUserNotificationActivationMode.Foreground
        secondAction.destructive = false
        secondAction.authenticationRequired = false
        
        // category
        let firstCategory:UIMutableUserNotificationCategory = UIMutableUserNotificationCategory()
        firstCategory.identifier = "FIRST_CATEGORY"
        
        let defaultActions:NSArray = [firstAction, secondAction]
        //let minimalActions:NSArray = [firstAction, secondAction]
        
        firstCategory.setActions(defaultActions as? [UIUserNotificationAction], forContext: UIUserNotificationActionContext.Default)
        firstCategory.setActions(defaultActions as? [UIUserNotificationAction] , forContext: UIUserNotificationActionContext.Minimal)
        
        let categories:NSSet = NSSet(objects: firstCategory)
        
        let notiTypes:UIUserNotificationType = [UIUserNotificationType.Alert, UIUserNotificationType.Badge, UIUserNotificationType.Sound]
        
        let mySettings = UIUserNotificationSettings(forTypes: notiTypes, categories: categories as? Set<UIUserNotificationCategory>)
        
        UIApplication.sharedApplication().registerUserNotificationSettings(mySettings)
        
        //location Manager Stuff
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()   //Need to monitor user location at all times
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.activityType = .Fitness
        locationManager.allowsBackgroundLocationUpdates = true
        
        // Movement threshold for new events
        locationManager.distanceFilter = 1.0
        
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge , .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        
        
        
        //First Launch Detection
        let isFirstLaunch = NSUserDefaults.isFirstLaunch()
        
        if isFirstLaunch {
            print("First Launch First Launch")
            
            //This will go into the true condition once working
            //First time, open a new page view controller.
//            storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let rootController = storyboard!.instantiateViewControllerWithIdentifier("IntroSurvey")
//            
            if let window = self.window {
               // window.rootViewController = rootController
            }
        } else {
                print("Not the first launch")
        }
        
//        storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let rootController = storyboard!.instantiateViewControllerWithIdentifier("TutorialController")
//        
// 
//     
        
        
        return true
        
    }
    
    func application(application: UIApplication,
                     handleActionWithIdentifier identifier:String?,
                                                for notification:UILocalNotification,
                                                    completionHandler: (() -> Void)){
        
        if (identifier == "RESIST_ACTION"){
            NSNotificationCenter.defaultCenter().postNotificationName("ResistPressed", object: nil)
        }else if (identifier == "SLIP_ACTION"){
            NSNotificationCenter.defaultCenter().postNotificationName("SlipPressed", object: nil)
        }
        
        completionHandler()
        
    }
    // GPS Handling stuff
    func handleRegionEvent(region: CLRegion!) {
        if let savedItems = NSUserDefaults.standardUserDefaults().arrayForKey(kSavedItemsKey) {
            for savedItem in savedItems {
                if let notification = NSKeyedUnarchiver.unarchiveObjectWithData(savedItem as! NSData) as? Notification {
                    if notification.identifier == region.identifier {
                        //return geotification
                        
                        
                        
                        
                        //for _ in 0...5 {
                            
                            print("Entered: \(notification.note)")
                        //}
                        
                        
                        // Show an alert if application is active
                        if UIApplication.sharedApplication().applicationState == .Active {
                            
                            let message = notification.note
                            
                            if var topController = UIApplication.sharedApplication().keyWindow?.rootViewController {
                                while let presentedViewController = topController.presentedViewController {
                                    topController = presentedViewController
                                }
                                alert.showSimpleAlertWithTitle(nil, message: message, viewController: topController)
                                print(topController.title)
                                
                            }
                        } else {
                            // Otherwise present a local notification
                            print("Background Triggered!")
                            let notif = UILocalNotification()
                            notif.alertBody = notification.note
                            notif.soundName = "Default";
                            UIApplication.sharedApplication().presentLocalNotificationNow(notif)
                        }
                    }
                }
            }
            // }
            
            
        }
        if regionArray.count > 0 {
            for r in regionArray {
                if r === region{
                    let index = regionArray.indexOf(r)
                    print("Removing \(notefromRegionIdentifier(region.identifier))")
                    regionArray.removeAtIndex(index!)
                }
            }
        }
        
        if regionArray.count == 0{
            locationManager.stopUpdatingLocation()
            print("Stopping All Updating Oh YEah!!!!")
        }
        
    }
    
    func handleOuterRegionEvent(region: CLRegion!) {
        
        // Show an alert if application is active
        if UIApplication.sharedApplication().applicationState == .Active {
            
            if let temp = notefromRegionIdentifier(region.identifier) {
                let message =  "Outer: \(temp)"
                
                if var topController = UIApplication.sharedApplication().keyWindow?.rootViewController {
                    while let presentedViewController = topController.presentedViewController {
                        topController = presentedViewController
                    }
                    alert.showSimpleAlertWithTitle(nil, message: message, viewController: topController)
                    print(topController.title)
                }
            }
        } else {
            // Otherwise present a local notification
            print("Background Triggered!")
            let notification = UILocalNotification()
            notification.alertBody = " Outer: \(notefromRegionIdentifier(region.identifier))"
            notification.soundName = "Default";
            UIApplication.sharedApplication().presentLocalNotificationNow(notification)
        }
    }
    
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if region is CLCircularRegion {
            
            let tempRegion = region as! CLCircularRegion
            if regionArray.isEmpty {
                regionArray.append(tempRegion)
                
            }else{
                
                for _ in regionArray {
                    if !regionArray.contains(tempRegion){
                        regionArray.append(tempRegion)
                        //handleOuterRegionEvent(region)
                    }
                }
            }
            handleOuterRegionEvent(region)
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        if region is CLCircularRegion {
            handleRegionEvent(region)
            print("Exited")
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocationCoordinate2D = manager.location!.coordinate
        
        /// Array Bidness
        print("locations = \(userLocation.latitude) \(userLocation.longitude)")
        print(regionArray.count)
        for r in regionArray {
            //print("Watching:  \(notefromRegionIdentifier(r.identifier)!)")
            if r.containsCoordinate(userLocation){
                //handleOuterRegionEvent(r)
                handleRegionEvent(r)
            }
        }
    }
    
    
    
    
    //Retrieve Geofence info
    func notefromRegionIdentifier(identifier: String) -> String? {
        if let savedItems = NSUserDefaults.standardUserDefaults().arrayForKey(kSavedItemsKey) {
            for savedItem in savedItems {
                if let notification = NSKeyedUnarchiver.unarchiveObjectWithData(savedItem as! NSData) as? Notification {
                    if notification.identifier == identifier {
                        return notification.note
                    }
                }
            }
        }
        return nil
    }
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.dkrathwell.ProtoTwo" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("ProtoTwo", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
}

