//
//  CostBenefitCell.swift
//  ProtoTwo
//
//  Created by Don on 2016-10-22.
//  Copyright © 2016 Don. All rights reserved.
//

import UIKit

class CostBenefitCell: UITableViewCell {


    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var message: UITextField!

    @IBOutlet weak var ratingTextField: UITextField!


    override func prepareForReuse() {
        super.prepareForReuse()
        
        //set cell to initial state here, reset or set values, etc.
        message.text = ""
        ratingTextField.text = ""
    }
    
    func updateAfterScroll(someArray: [DescriptionAndRating]){
        
    
    }















}
