//
//  FeelingCellDataModel.swift
//  ProtoTwo
//
//  Created by Don on 2016-10-20.
//  Copyright © 2016 Don. All rights reserved.
//

import Foundation
import UIKit

class FeelingCellDataModel {

    //Properties
    let feeling: String
    var isVisible: Int
    let isExpandable: Int
    var isExpanded: Int
    let additionalRows: Int
    let cellIdentifier: String
    let arrayIndex: Int
    
    
    init (feeling: String, isVisible: Int, isExpandable: Int, additionalRows: Int, cellIdentifier: String, arrayIndex: Int, isExpanded: Int){
        self.feeling = feeling
        self.isVisible = isVisible
        self.isExpandable = isExpandable
        self.isExpanded = isExpanded
        self.additionalRows = additionalRows
        self.cellIdentifier = cellIdentifier
        self.arrayIndex = arrayIndex
            //print("Making a cell for \(feeling)")
    }
}