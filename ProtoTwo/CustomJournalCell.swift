//
//  CustomJournalCell.swift
//  ProtoTwo
//
//  Created by Don on 2017-01-24.
//  Copyright © 2017 Don. All rights reserved.
//

import UIKit

class CustomJournalCell: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var feelingLabel: UILabel!
    @IBOutlet weak var cravingLabel: UILabel!
    @IBOutlet weak var didSmokeImage: UIImageView!
    @IBOutlet weak var disclosureButton: UIButton!
    
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
            
            timeLabel?.font = bigFont
            timeLabel?.textColor = primaryColor
            
            cravingLabel?.font = smallFont
            cravingLabel?.textColor = primaryColor
            
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        //Do reset here
        
        //feelingLabel.text = ""
        self.backgroundColor = UIColor.whiteColor()
        
    }
}
