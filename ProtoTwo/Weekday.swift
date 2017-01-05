//
//  Weekday.swift
//  ProtoTwo
//
//  Created by Don on 2016-07-22.
//  Copyright © 2016 Don. All rights reserved.
//

import Foundation
import UIKit

let kWeekdayNameKey = "nameOfWeek"
let kWeekdayCheckBoolKey = "checkBool"
let kWeekdayWeekdayNumKey = "weekdayNum"

class Weekday:NSObject, NSCoding{
    var nameOfWeek:String!
    var checkBool:Bool!
    var weekdayNum:Int!
    
    private var listOfWeekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    init (checkBool:Bool, weekdayNum:Int){
        self.nameOfWeek = listOfWeekdays[weekdayNum]
        self.checkBool = checkBool
        self.weekdayNum = weekdayNum
    }
    
    required init?(coder decoder: NSCoder) {
        nameOfWeek = decoder.decodeObjectForKey(kWeekdayNameKey) as! String
        checkBool = decoder.decodeBoolForKey(kWeekdayCheckBoolKey)
        weekdayNum = Int(decoder.decodeIntegerForKey(kWeekdayWeekdayNumKey))
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(nameOfWeek, forKey: kWeekdayNameKey)
        coder.encodeBool(checkBool, forKey: kWeekdayCheckBoolKey)
        coder.encodeInt(Int32(weekdayNum), forKey: kWeekdayWeekdayNumKey)
    }
}