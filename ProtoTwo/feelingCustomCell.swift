//
//  feelingCustomCell.swift
//  ProtoTwo
//
//  Created by Don on 2016-10-09.
//  Copyright © 2016 Don. All rights reserved.
//

import Foundation
import UIKit

class FeelingCustomCell: UITableViewCell {

  
    @IBOutlet weak var feelingLabel: UILabel!
    
    
    var isVisible = false
    
    // MARK: Constants
    
    let bigFont = UIFont(name: "Avenir-Book", size: 17.0)
    
    let smallFont = UIFont(name: "Avenir-Light", size: 17.0)
    
    let primaryColor = UIColor.blackColor()
    
    let secondaryColor = UIColor.lightGrayColor()   
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        if feelingLabel != nil {
            feelingLabel?.font = bigFont
            feelingLabel?.textColor = primaryColor
        }
        
//        if detailTextLabel != nil {
//            detailTextLabel?.font = smallFont
//            detailTextLabel?.textColor = secondaryColor
//        }
        
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //Do reset here

        feelingLabel.text = ""
        self.backgroundColor = UIColor.whiteColor()
        
    }


}
