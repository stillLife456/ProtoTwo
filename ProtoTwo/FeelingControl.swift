//
//  FeelingController.swift
//  ProtoTwo
//
//  Created by Don on 2016-10-03.
//  Copyright © 2016 Don. All rights reserved.
//

import Foundation
import UIKit

//class FeelingControl: UIView {
//    
//    // MARK: Properties
//    
//    var rating = 0 {
//        didSet {
//            setNeedsLayout()
//        }
//    }
//    
//    var feelingButtons = [UIButton]()
//    let starCount = 5
//    let spacing = 15
//    
//    
//    // MARK: Initialization
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        
////        let filledNoSignImage = UIImage(named: "filledNoSign")
////        let emptyNoSignImage = UIImage(named: "emptyNoSign")
//        
//        for _ in 0..<starCount {
//            let button = UIButton()
////            button.setImage(emptyNoSignImage, forState: .Normal)
////            button.setImage(filledNoSignImage, forState: .Selected)
////            button.setImage(filledNoSignImage, forState: [.Highlighted, .Selected])
//            button.adjustsImageWhenHighlighted = false
//            button.addTarget(self, action: #selector(FeelingControl.buttonTapped(_:)), forControlEvents: .TouchDown)
//            feelingButtons += [button]
//            addSubview(button)
//        }
//    }
//    
//    override func layoutSubviews() {
//        
//        let size = 44
//        var i = 0
//        
//        var buttonFrame = CGRect(x: 0, y: 0, width: size, height: size)
//        
//        // Offset each button's origin by the length of the button plus spacing.
//        for (index, button) in ratingButtons.enumerate() {
//            buttonFrame.origin.x = CGFloat(index * (size + spacing))
//            button.frame = buttonFrame
//        }
//        updateButtonSelectionStates()
//    }
//    
//    override func intrinsicContentSize() -> CGSize {
//        let buttonSize = Int(frame.size.height)
//        let width = (buttonSize * starCount) + (spacing * (starCount - 1))
//        return CGSize(width: width, height: buttonSize)
//    }
//    
//    
//    // MARK: Button Action
//    
//    func buttonTapped(button: UIButton) {
//        
//        //print("Button pressed 👍")
//        rating = ratingButtons.indexOf(button)! + 1
//        updateButtonSelectionStates()
//    }
//    
//    func updateButtonSelectionStates() {
//        
//        for (index, button) in ratingButtons.enumerate() {
//            // If the index of a button is less than the rating, that button should be selected.
//            button.selected = index < rating
//        }
//    }
//}
