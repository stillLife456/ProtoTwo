//
//  Notification.swift
//  ProtoTwo
//
//  Created by Don on 2016-07-21.
//  Copyright © 2016 Don. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

let kNotificationLatitudeKey = "latitude"
let kNotificationLongitudeKey = "longitude"
let kNotificationRadiusKey = "radius"
let kNotificationIdentifierKey = "identifier"
let kNotificationNoteKey = "note"
let kNotificationEventTypeKey = "eventType"

let kNotificationEverydayKey = "everydayOn"
let kNotificationWeekdayKey = "weekdays"
let kNotificaationTimeKey = "time"
let kNotificationLocalNotificationKey = "singleTimedNotification"

let kNotificationTimedBoolKey = "timedNotificationOn"
let kNotificationGPSBoolKey = "gpsNotificationOn"


enum EventType: Int {
    case OnEntry = 0
    case OnExit
}

class Notification: NSObject, NSCoding, MKAnnotation {
    
    //MARK: Properties
    
    var coordinate: CLLocationCoordinate2D
    var radius: CLLocationDistance
    var identifier: String
    var note: String
    var eventType: EventType
    
    var localNotifications = [UILocalNotification]()
    
    private let calendar = NSCalendar.currentCalendar()
    private var dateComponents = NSDateComponents()
    private var dateFormatter = NSDateFormatter()
    
    var singleTimedNotification = [UILocalNotification]()
    var weekdays = [Weekday]()
    var time:NSDate
    var everydayOn:Bool
    
    var timeNotifiOn:Bool
    var gpsNotifiOn:Bool
    
    var title: String? {
        if note.isEmpty {
            return "No Note"
        }
        return note
    }
    
    var subtitle: String? {
        let eventTypeString = eventType == .OnEntry ? "On Entry" : "On Exit"
        return "Radius: \(radius)m - \(eventTypeString)"
    }
    
    
    // GPS Notification ON
    init(coordinate: CLLocationCoordinate2D, radius: CLLocationDistance, identifier: String, note: String, eventType: EventType, time:NSDate, weekdays:[Weekday], everydayOn:Bool, timedNotifiOn:Bool, gpsNotifiOn:Bool) {
        self.coordinate = coordinate
        self.radius = radius
        self.identifier = identifier
        self.note = note
        self.eventType = eventType
        
        self.time = time
        self.weekdays = weekdays
        self.everydayOn = everydayOn
        self.timeNotifiOn = timedNotifiOn
        self.gpsNotifiOn = gpsNotifiOn
    }
    
    
    // MARK: NSCoding
    
    required init?(coder decoder: NSCoder) {
        let latitude = decoder.decodeDoubleForKey(kNotificationLatitudeKey)
        let longitude = decoder.decodeDoubleForKey(kNotificationLongitudeKey)
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        radius = decoder.decodeDoubleForKey(kNotificationRadiusKey)
        identifier = decoder.decodeObjectForKey(kNotificationIdentifierKey) as! String
        note = decoder.decodeObjectForKey(kNotificationNoteKey) as! String
        eventType = EventType(rawValue: decoder.decodeIntegerForKey(kNotificationEventTypeKey))!
        
        singleTimedNotification = decoder.decodeObjectForKey(kNotificationLocalNotificationKey) as! [UILocalNotification]
        everydayOn = decoder.decodeBoolForKey(kNotificationEverydayKey)
        weekdays = decoder.decodeObjectForKey(kNotificationWeekdayKey) as! [Weekday]
        time = decoder.decodeObjectForKey(kNotificaationTimeKey) as! NSDate
        
        timeNotifiOn = decoder.decodeBoolForKey(kNotificationTimedBoolKey)
        gpsNotifiOn = decoder.decodeBoolForKey(kNotificationGPSBoolKey)
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeDouble(coordinate.latitude, forKey: kNotificationLatitudeKey)
        coder.encodeDouble(coordinate.longitude, forKey: kNotificationLongitudeKey)
        coder.encodeDouble(radius, forKey: kNotificationRadiusKey)
        coder.encodeObject(identifier, forKey: kNotificationIdentifierKey)
        coder.encodeObject(note, forKey: kNotificationNoteKey)
        coder.encodeInt(Int32(eventType.rawValue), forKey: kNotificationEventTypeKey)
        
        coder.encodeObject(singleTimedNotification, forKey: kNotificationLocalNotificationKey)
        coder.encodeBool(everydayOn, forKey: kNotificationEverydayKey)
        coder.encodeObject(weekdays, forKey: kNotificationWeekdayKey)
        coder.encodeObject(time, forKey: kNotificaationTimeKey)
        coder.encodeBool(timeNotifiOn, forKey: kNotificationTimedBoolKey)
        coder.encodeBool(gpsNotifiOn, forKey: kNotificationGPSBoolKey)
    }
    
    func addTimes(time:NSDate, weekdays:[Weekday]) -> [NSDate]{
        var tempWeekdays = [NSDate]()
        dateComponents = calendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day,NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Weekday], fromDate: time)
        dateComponents.second = 0
        
        var difference = 0
        var tempNum = 0
        
        for temp in weekdays {
            if temp.checkBool! {
                tempNum = temp.weekdayNum
                difference = calculateDifference(tempNum, dateComp: dateComponents.weekday)
                dateComponents.day = dateComponents.day + difference
                tempWeekdays.append(calendar.dateFromComponents(dateComponents)!)
                dateComponents.day = dateComponents.day - difference
            }
        }
        return tempWeekdays
    }
    
    private func calculateDifference(temp:Int, dateComp:Int) -> Int {
        var difference = 0
        if temp < dateComp {
            difference = 7 - dateComp + temp
        } else if temp > dateComp {
            difference = temp - dateComp
        }
        return difference
    }
}


