//
//  CostBenefitSheetModel.swift
//  ProtoTwo
//
//  Created by Don on 2016-10-13.
//  Copyright © 2016 Don. All rights reserved.
//

import Foundation
import UIKit

class AllCostBenefitSheets {
    
    //Making a singleton
    static let sharedInstance = AllCostBenefitSheets()
    
    //MARK: Properties
    var allSheetsArray = [CostBenefitSheetModel]()
    
    private init (){
        if let savedCostBenSheets = loadCostBenSheets() {
            allSheetsArray += savedCostBenSheets
        }else {
            print("So confused")
        }
    }
    
    func printAllSheets(){
        
        for item in allSheetsArray{
          print(item.dateMade)
        
        }
    }
    
    // MARK: NSCoding
    func saveCostBenSheets() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(allSheetsArray, toFile: CostBenefitSheetModel.ArchiveURL.path!)
        
        if !isSuccessfulSave {
            print("Failed to save journal...")
        }
    }
    
    
    
    func loadCostBenSheets() -> [CostBenefitSheetModel]? {
        return  NSKeyedUnarchiver.unarchiveObjectWithFile(CostBenefitSheetModel.ArchiveURL.path!) as? [CostBenefitSheetModel]
    }

}

class CostBenefitSheetModel: NSObject, NSCoding {
   
    var contents: [DescriptionAndRating]
    var dateMade: NSDate

    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("allCostBenefitSheets")
    
    struct PropertyKey {
        
        static let costBenefitSheetsKey = "costBenefitSheet"
        static let dateMadeKey = "dateMade"


    }
    
    init (contents: [DescriptionAndRating], dateMade: NSDate){
        
        self.contents = contents
        self.dateMade = dateMade

        super.init()
    }
    
    // MARK: NSCoding
    func  encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(contents, forKey: PropertyKey.costBenefitSheetsKey)////ytdyduytd
        aCoder.encodeObject(dateMade, forKey: PropertyKey.dateMadeKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let contents = aDecoder.decodeObjectForKey(PropertyKey.costBenefitSheetsKey) as! [DescriptionAndRating]
        let dateMade = aDecoder.decodeObjectForKey(PropertyKey.dateMadeKey) as! NSDate
        
        // Must call designated initializer.
        self.init(contents: contents, dateMade: dateMade)
        
    }

    
  
    
}
