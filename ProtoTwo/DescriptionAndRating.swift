//
//  DescriptionAndRating.swift
//  ProtoTwo
//
//  Created by Don on 2016-10-23.
//  Copyright © 2016 Don. All rights reserved.
//

import Foundation
import UIKit

class DescriptionAndRating: NSObject, NSCoding {

    let descriptionString: String
    let rating: Int
    let sectionInt: Int
    
    struct PropertyKey {
        
        static let descriptionStringKey = "descriptionString"
        static let ratingKey = "rating"
        static let sectionIntKey = "sectionInt"

    }
    
    init (description: String, rating: Int, sectionInt: Int){
    
    self.descriptionString = description
    self.rating = rating
    self.sectionInt = sectionInt
    
    }
    
    func  encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(descriptionString, forKey: PropertyKey.descriptionStringKey)
        aCoder.encodeInteger(rating, forKey: PropertyKey.ratingKey)
        aCoder.encodeInteger(sectionInt, forKey: PropertyKey.sectionIntKey)

    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let descriptionString = aDecoder.decodeObjectForKey(PropertyKey.descriptionStringKey) as! String
        let rating = aDecoder.decodeIntegerForKey(PropertyKey.ratingKey)
        let sectionInt = aDecoder.decodeIntegerForKey(PropertyKey.sectionIntKey)

        
        // Must call designated initializer.
        self.init(description: descriptionString, rating: rating, sectionInt: sectionInt)
    }


}

