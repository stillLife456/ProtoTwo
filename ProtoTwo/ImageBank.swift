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
    var quitDayImage = UIImage()
    var quitDayImageGrey = UIImage()
    var smokingNo = UIImage()
    var smokingYes = UIImage()
    var addButton = UIImage()
    var costBen = UIImage()
    var blankImage = UIImage()
    var shrug = UIImage()
    
    
    let wolfHeadSize = CGSize(width: 20,height: 20)
    let buttonSize = CGSize(width: 80,height: 80)
    let addButtonSize = CGSize(width: 20,height: 20)
    
    
    var appPhotoNamesArray = [PhotoName]()
    //For storing photos
    var imagesDirectoryPath:String!
    

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
        if let tempImage4 = UIImage(named:"quitDayImage"){
            self.quitDayImage  = imageResize(tempImage4, sizeChange: wolfHeadSize)
        }
        if let tempImage5 = UIImage(named:"quitDayImage-Grey"){
            self.quitDayImageGrey  = imageResize(tempImage5, sizeChange: wolfHeadSize)
        }
        if let tempImage6 = UIImage(named:"yesSmokingClear"){
            self.smokingYes  = imageResize(tempImage6, sizeChange: buttonSize)
        }
        if let tempImage7 = UIImage(named:"noSmokingClear"){
            self.smokingNo  = imageResize(tempImage7, sizeChange: buttonSize)
        }
        if let tempImage8 = UIImage(named:"addButton"){
        self.addButton  = imageResize(tempImage8, sizeChange: addButtonSize)
        }
        if let tempImage9 = UIImage(named:"cost"){
        self.costBen = imageResize(tempImage9, sizeChange: wolfHeadSize)
        }
        if let tempImage10 = UIImage(named:"blankImage"){
            self.blankImage = imageResize(tempImage10, sizeChange: wolfHeadSize)
        }
        if let tempImage11 = UIImage(named:"shrug"){
            self.shrug = imageResize(tempImage11, sizeChange: wolfHeadSize)
            
            if let tempAppPhotoNamesArray = loadPhotoNames(){
                print("yeah")
                appPhotoNamesArray += tempAppPhotoNamesArray
            }
        }
    
    setUpDirectory()
    
    }
    
    func savePhotoNames() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(appPhotoNamesArray, toFile: PhotoName.ArchiveURL.path!)
        
        if !isSuccessfulSave {
            print("Failed to save photos...")
        }
    }

    
    func loadPhotoNames()-> [PhotoName]?{
          return NSKeyedUnarchiver.unarchiveObjectWithFile(PhotoName.ArchiveURL.path!) as? [PhotoName]
        
    }
    
    func setUpDirectory(){
        
        //Create/check folder for photos
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        // Get the Document directory path
        let documentDirectorPath:String = paths[0]
        
        // Create a new path for the new images folder
        imagesDirectoryPath = documentDirectorPath.stringByAppendingString("/FeedTheWolfPhotos")
        var objcBool:ObjCBool = true
        let isExist = NSFileManager.defaultManager().fileExistsAtPath(imagesDirectoryPath, isDirectory: &objcBool)
       
        // If the folder with the given path doesn't exist already, create it
        if isExist == false{
            do{
                try NSFileManager.defaultManager().createDirectoryAtPath(imagesDirectoryPath, withIntermediateDirectories: true, attributes: nil)
            }catch{
                print("Something went wrong while creating a new folder")
            }
        }else{
            print("Image Directory already exists")
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

//Custom Object for NSCoding

class PhotoName: NSObject, NSCoding {

    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("allPhotoNames")

    struct PropertyKey {
        
        static let photoNameKey = "photoName"

    }
    
    //Mark: Properties
    var photoName: String
    
    init? (photoName: String ){
        self.photoName = photoName

        
        super.init()
        
        //        if title.isEmpty {
        //            return nil
        //        }
    }

    
    // MARK: NSCoding
    func  encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(photoName, forKey: PropertyKey.photoNameKey)

    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let photoName = aDecoder.decodeObjectForKey(PropertyKey.photoNameKey) as! String

        
        // Must call designated initializer.
        self.init(photoName: photoName)
    }

    

}
