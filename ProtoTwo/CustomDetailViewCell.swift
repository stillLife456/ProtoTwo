//
//  CustomDetailViewCell.swift
//  ProtoTwo
//
//  Created by Don on 2017-01-24.
//  Copyright © 2017 Don. All rights reserved.
//

import Foundation
import UIKit

class CustomDetailViewCell: UITableViewCell {

    @IBOutlet weak var feelingLabel: UILabel!
    @IBOutlet weak var cravingLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var didSmokeImage: UIImageView!
    @IBOutlet weak var arrowButton: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        if feelingLabel != nil {
            print("Feelinglabel cool")
        }
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
