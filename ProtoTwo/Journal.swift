//
//  Journal.swift
//  ProtoTwo
//
//  Created by Don on 2016-07-01.
//  Copyright © 2016 Don. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class Journal{
    
    //Making a singleton
    static let sharedInstance = Journal()
    
    //MARK: Properties
    var journalArray = [JournalEntry]()
    var sortedJournalDict = [String: [ JournalEntry]]()
    
    let calendar: NSCalendar! = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
    
    private init (){
        if let savedJournalEntries = loadJournalEntries() {
            journalArray += savedJournalEntries
            
            
        }else {
            print("So confused")
        }
    }
    
    func getJustDate(date: NSDate)->String{
    
        
        let formatter:NSDateFormatter = NSDateFormatter()
       
        formatter.dateFormat = "MM/dd/yyyy "
        let tempString = formatter.stringFromDate(date)
        return tempString
    
    }
    
    
    func sortArray(){
        //print("This is sorting the array")
        
        for j in journalArray{
            let date = getJustDate(j.entryTime)
            
            let keyExists = sortedJournalDict.indexForKey(date) != nil
//            print(date)
//            print ("Does Key exist?: \(keyExists)")
            if keyExists {
                sortedJournalDict[date]?.append(j)
                
            }else{
                
                sortedJournalDict[date] = [j]
            }

            
        }
    
    
    
    }
    
    func printWholeSortedArray(){
        
       // print("This is printing the array")
        
        for (key,value) in sortedJournalDict {
            
            //print("\(key)")
            for i in value {
                let temp = i as JournalEntry
               // print("\t\(temp.displayTime)")
            
            }
        }
    }
    
    func printWholeArray(){
        
        for e in journalArray{
            print(" ")
            print(e.title)
            print(e.entryTime)
            print(e.displayTime)
            print(e.note)
            
        }
    }
    
    // MARK: NSCoding
    func saveJournalEntries() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(journalArray, toFile: JournalEntry.ArchiveURL.path!)
        
        if !isSuccessfulSave {
            print("Failed to save journal...")
        }
    }
    
    
    
    func loadJournalEntries() -> [JournalEntry]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(JournalEntry.ArchiveURL.path!) as? [JournalEntry]
    }
}

class JournalEntry: NSObject, NSCoding, MKAnnotation{
    
    // MARK: Properties
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var entryTime: NSDate
    var displayTime: String
    var note: String?
    var quitDayFlag: Bool = false
    var cravingRating: Int
    var feelingOne:String?
    var feelingTwo:String?
    var latt:Double?
    var long:Double?
    var coord: CLLocationCoordinate2D?
    var radius: CLLocationDistance
    var didSmoke: Bool?
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("allJournalEntries")
    
    // MARK: Types
    
    struct PropertyKey {
        
        static let titleKey = "title"
        static let entryTimeKey = "entryTime"
        static let displayTimeKey = "displayTime"
        static let noteKey = "note"
        static let quitDayFlagKey = "quitDayFlag"
        static let cravingRatingKey = "cravingRating"
        static let feelingOneKey = "feelingOne"
        static let feelingTwoKey = "feelingTwo"
        static let lattKey = "lattKey"
        static let longKey = "longKey"
        static let didSmokeKey = "didSmokeKey"
    }
    
    init? (title: String, entryTime: NSDate, displayTime: String, note: String, quitDayFlag: Bool, cravingRating: Int, feelingOne: String, feelingTwo: String, latt: Double, long: Double, didSmoke: Bool ){
        self.title = title
        self.entryTime = entryTime // As an NSDate
        self.displayTime = displayTime // As String
        self.note = note
        self.quitDayFlag = quitDayFlag
        self.cravingRating = cravingRating
        self.feelingOne = feelingOne
        self.feelingTwo = feelingTwo
        self.latt = latt
        self.long = long
        self.coordinate = CLLocationCoordinate2D(latitude: latt, longitude: long)
        self.radius = 10
        self.didSmoke = didSmoke
        
        super.init()
        
//        if title.isEmpty {
//            return nil
//        }
    }
    
    
    // MARK: NSCoding
    func  encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title, forKey: PropertyKey.titleKey)
        aCoder.encodeObject(entryTime, forKey: PropertyKey.entryTimeKey)
        aCoder.encodeObject(displayTime, forKey: PropertyKey.displayTimeKey)
        aCoder.encodeObject(note, forKey: PropertyKey.noteKey)
        aCoder.encodeBool(quitDayFlag, forKey: PropertyKey.quitDayFlagKey)
        aCoder.encodeInteger(cravingRating, forKey: PropertyKey.cravingRatingKey)
        aCoder.encodeObject(feelingOne, forKey: PropertyKey.feelingOneKey)
        aCoder.encodeObject(feelingTwo, forKey: PropertyKey.feelingTwoKey)
        aCoder.encodeDouble(latt!, forKey: PropertyKey.lattKey)
        aCoder.encodeDouble(long!, forKey: PropertyKey.longKey)
        aCoder.encodeBool(didSmoke!, forKey: PropertyKey.didSmokeKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObjectForKey(PropertyKey.titleKey) as! String
        let entryTime = aDecoder.decodeObjectForKey(PropertyKey.entryTimeKey) as! NSDate
        let displayTime = aDecoder.decodeObjectForKey(PropertyKey.displayTimeKey) as! String
        let note = aDecoder.decodeObjectForKey(PropertyKey.noteKey) as! String
        let quitDayFlag = aDecoder.decodeBoolForKey(PropertyKey.quitDayFlagKey)
        let cravingRating = aDecoder.decodeIntegerForKey(PropertyKey.cravingRatingKey)
        let feelingOne = aDecoder.decodeObjectForKey(PropertyKey.feelingOneKey) as! String
        let feelingTwo = aDecoder.decodeObjectForKey(PropertyKey.feelingTwoKey) as! String
        let latt = aDecoder.decodeDoubleForKey(PropertyKey.lattKey)
        let long = aDecoder.decodeDoubleForKey(PropertyKey.longKey)
        let didSmoke = aDecoder.decodeBoolForKey(PropertyKey.didSmokeKey)
        
        // Must call designated initializer.
        self.init(title: title, entryTime: entryTime, displayTime: displayTime, note: note, quitDayFlag: quitDayFlag, cravingRating: cravingRating, feelingOne: feelingOne, feelingTwo: feelingTwo, latt: latt, long: long, didSmoke: didSmoke)
    }
}

