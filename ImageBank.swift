//
//  ImageBank.swift
//  ProtoTwo
//
//  Created by Don on 2016-07-04.
//  Copyright © 2016 Don. All rights reserved.
//

import Foundation
import UIKit

class ImageBank {
    
    //Making a singleton
    static let sharedInstance = ImageBank()

    var goodWolfHead = UIImage()
    var badWolfHead = UIImage()
    var nothingImage = UIImage()
    let wolfHeadSize = CGSizeMake(30,30)
    

   private init (){
        
        if let tempImage = UIImage(named:"badWolfHead"){
            self.badWolfHead = imageResize(tempImage, sizeChange: wolfHeadSize)
        }
        if let tempImage2 = UIImage(named:"goodWolfHead") {
            self.goodWolfHead = imageResize(tempImage2, sizeChange: wolfHeadSize)
        }
        if let tempImage3 = UIImage(named:"nothing"){
            self.nothingImage = imageResize(tempImage3, sizeChange: wolfHeadSize)
        }
    
    }
    func imageResize (image: UIImage, sizeChange:CGSize)-> UIImage{
        
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        image.drawInRect(CGRect(origin: CGPointZero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage
    }
    

}