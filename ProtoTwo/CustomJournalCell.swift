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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
