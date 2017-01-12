//
//  CustomFeelingCell.swift
//  ProtoTwo
//
//  Created by Don on 2016-10-16.
//  Copyright © 2016 Don. All rights reserved.
//

import Foundation
import UIKit

protocol CustomCellDelegate {

}

class CustomCell: UITableViewCell {
    
    // MARK: IBOutlet Properties
    
//    @IBOutlet weak var textField: UITextField!
//    
//    @IBOutlet weak var datePicker: UIDatePicker!
//    
//    @IBOutlet weak var lblSwitchLabel: UILabel!
//    
//    @IBOutlet weak var swMaritalStatus: UISwitch!
//    
//    @IBOutlet weak var slExperienceLevel: UISlider!
    
    
    // MARK: Constants
    
    let bigFont = UIFont(name: "Avenir-Book", size: 17.0)
    
    let smallFont = UIFont(name: "Avenir-Light", size: 17.0)
    
    let primaryColor = UIColor.blackColor()
    
    let secondaryColor = UIColor.lightGrayColor()
    
    
    // MARK: Variables
    
    var delegate: CustomCellDelegate!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        if textLabel != nil {
            textLabel?.font = bigFont
            textLabel?.textColor = primaryColor
        }
        
        if detailTextLabel != nil {
            detailTextLabel?.font = smallFont
            detailTextLabel?.textColor = secondaryColor
        }
        
//        if textField != nil {
//            textField.font = bigFont
//            textField.delegate = self
//        }
//        
//        if lblSwitchLabel != nil {
//            lblSwitchLabel.font = bigFont
//        }
//        
//        if slExperienceLevel != nil {
//            slExperienceLevel.minimumValue = 0.0
//            slExperienceLevel.maximumValue = 10.0
//            slExperienceLevel.value = 0.0
//        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
}
}
