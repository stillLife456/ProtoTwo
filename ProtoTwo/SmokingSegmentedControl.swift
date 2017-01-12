//
//  SmokingSegmentedControl.swift
//  ProtoTwo
//
//  Created by Don on 2016-09-25.
//  Copyright © 2016 Don. All rights reserved.
//

import UIKit

@IBDesignable class SmokingSegmentedControl: UIControl{

    private var labels = [UILabel]()
    var items: [String] = ["One", "Two"]{
        didSet{
            setUpLabels()
        }
    }
    
    
    private var finalImages = [UIImageView]()
    var images = [ImageBank.sharedInstance.smokingYes, ImageBank.sharedInstance.smokingNo]{
        didSet{
            setUpLabels()
        }
    }
    
    
    var thumbView = UIView()
    
   
    
    var selectedIndex: Int = 0 {
        didSet{
            displayNewSelectedIndex()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       // loadImages()
        setUpView()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
         //loadImages()
        setUpView()
       
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var selectedFrame = self.bounds
        let newWidth = selectedFrame.width / CGFloat(images.count)
        selectedFrame.size.width = newWidth
        thumbView.frame = selectedFrame
        thumbView.backgroundColor = UIColor.whiteColor()
        thumbView.layer.cornerRadius = thumbView.frame.height / 2
        
        let labelHeight = self.bounds.height
        let labelWidth = self.bounds.width / CGFloat(finalImages.count)
        
        for index in 0...finalImages.count - 1 {
            let tempImage = finalImages[index]
            let xPosition = CGFloat(index) * labelWidth
            tempImage.frame = CGRect(x: xPosition, y: 0, width: labelWidth, height: labelHeight)
            
            
            
        }
        
    }
    
    func loadImages () {
            images[0] = ImageBank.sharedInstance.smokingYes
            images[1] = ImageBank.sharedInstance.smokingNo
    
    }
    
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        let location = touch.locationInView(self)
        var calculatedIndex: Int?
        
        for (index, item) in finalImages.enumerate(){
            if item.frame.contains(location){
                calculatedIndex = index
            }
        }
        if calculatedIndex != nil {
            selectedIndex = calculatedIndex!
            sendActionsForControlEvents(.ValueChanged)
        }
        return false
    }
    
    func setUpView() {
        layer.cornerRadius = frame.height / 2
        //layer.borderColor = (UIColor.blackColor() as! CGColor)
        
        backgroundColor = UIColor.grayColor()
        setUpLabels()
        insertSubview(thumbView, atIndex: 0)
    }
    
    func setUpLabels(){
        for img in finalImages {
            img.removeFromSuperview()
            
        }
        finalImages.removeAll(keepCapacity: true)
    
    for index in 1...images.count {
    let tempImage = UIImageView(frame: CGRect.zero)
        tempImage.image = images[index - 1]
        //label.textAlignment = .Center
        //label.textColor = UIColor.blackColor()
        self.addSubview(tempImage)
        finalImages.append(tempImage)
        }
    }
    
    func displayNewSelectedIndex()  {
        let tempImage = finalImages[selectedIndex]
        self.thumbView.frame = tempImage.frame
    }
}
