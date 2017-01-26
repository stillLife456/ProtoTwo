//
//  CellGraphView.swift
//  ProtoTwo
//
//  Created by Don on 2017-01-09.
//  Copyright © 2017 Don. All rights reserved.
//

import Foundation
import UIKit
import JTAppleCalendar
import Charts

class CellGraphView: JTAppleDayCellView {
   
    

    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var imageForCell: UIImageView!

    @IBOutlet weak var chartView: CellGraphObject!
    
    
    var normalDayColor = UIColor.blackColor()
    var weekendDayColor = UIColor.grayColor()
    



    func setupCellBeforeDisplay(cellState: CellState, date: NSDate) {
        
        //self.backgroundColor = UIColor(colorWithHexValue: 0x3A284C )
        
        imageForCell.hidden = false
        imageForCell.contentMode = UIViewContentMode.ScaleAspectFit
        
        // get images and set sizes
        //setWolfImages()
        
        // Setup Cell text
        dateLabel.text =  cellState.text
        //print(cellState.text)
        //dayLabel.text =  "!"
        
        
        // Setup text color
        //configureTextColor(cellState)
        
      
        
        
        // Configure Visibility
        configureVisibility(cellState)

    }
    
    func configureVisibility(cellState: CellState) {
        if
            cellState.dateBelongsTo == .ThisMonth ||
                cellState.dateBelongsTo == .PreviousMonthWithinBoundary ||
                cellState.dateBelongsTo == .FollowingMonthWithinBoundary {
            self.hidden = false
        } else {
            self.hidden = false
        }
    }
    
    func configureTextColor(cellState: CellState) {
        if cellState.dateBelongsTo == .ThisMonth {
            dateLabel.textColor = normalDayColor
        } else {
            dateLabel.textColor = weekendDayColor
        }
        
        
    }

    func cellSelectionChanged(cellState: CellState) {
        if cellState.isSelected == true {
            
//            if selectedView.hidden == true {
//                //configueViewIntoBubbleView(cellState)
//                self.userInteractionEnabled = false
//                selectedView.animateWithBounceEffect(withCompletionHandler: {
//                    self.userInteractionEnabled = true
//                })
//            }
//        } else {
//            //configueViewIntoBubbleView(cellState, animateDeselection: true) ************************* THIS IS STILL A PROBLEM
//        }
        
    }
   
    }
}
