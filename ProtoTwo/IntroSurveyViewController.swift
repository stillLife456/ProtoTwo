//
//  IntroSurveyViewController.swift
//  ProtoTwo
//
//  Created by Don on 2017-01-14.
//  Copyright © 2017 Don. All rights reserved.
//



import UIKit


class IntroSurveyViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    @IBOutlet weak var numSmokesDayInputField: UITextField!
    
    @IBOutlet weak var timeAfterWaking: UITextField!

    
    @IBOutlet weak var imagePicked: UIImageView!
    @IBOutlet weak var doneButton: UIButton!
    
    //For storing photos
   // var imagesDirectoryPath:String!
    var images:[UIImage]!
    var titles:[String]!
    
    @IBOutlet var takePhotoButton: UIView!
    @IBOutlet var choosePhotoButton: UIView!
    let numberToolbar: UIToolbar = UIToolbar()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //add done to number pad
        numberToolbar.barStyle = UIBarStyle.BlackTranslucent
        numberToolbar.items=[
            UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(cancelKeyboard)),
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Apply", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(applyKeyboard))
        ]
        numberToolbar.sizeToFit()
        numSmokesDayInputField.inputAccessoryView = numberToolbar
        timeAfterWaking.inputAccessoryView = numberToolbar
        
       numSmokesDayInputField.delegate = self
        timeAfterWaking.delegate = self
        numSmokesDayInputField.keyboardType = UIKeyboardType.DecimalPad
        timeAfterWaking.keyboardType = UIKeyboardType.DecimalPad
        
//        //Create/check folder for photos
//        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
//        // Get the Document directory path
//        let documentDirectorPath:String = paths[0]
//        // Create a new path for the new images folder
//        imagesDirectoryPath = documentDirectorPath.stringByAppendingString("/FeedTheWolfPhotos")
//        var objcBool:ObjCBool = true
//        let isExist = NSFileManager.defaultManager().fileExistsAtPath(imagesDirectoryPath, isDirectory: &objcBool)
//        // If the folder with the given path doesn't exist already, create it
//        if isExist == false{
//            do{
//                try NSFileManager.defaultManager().createDirectoryAtPath(imagesDirectoryPath, withIntermediateDirectories: true, attributes: nil)
//            }catch{
//                print("Something went wrong while creating a new folder")
//            }
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func textFieldDidEndEditing(textField: UITextField) {
        
     
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
        
    }
   
    //Funcs for number keyboard toolbar Behaviour
    func applyKeyboard (textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func cancelKeyboard (textField: UITextField) {
        textField.text=""
        textField.resignFirstResponder()
    }
    
    
    
    @IBAction func donePressed(sender: UIButton){
        let numSmokesDay = Int(numSmokesDayInputField.text!)
        let timeSinceWakingSmoke = Int(timeAfterWaking.text!)
        print(numSmokesDay)
        print(timeSinceWakingSmoke)
       
        let imageData = UIImageJPEGRepresentation(imagePicked.image!, 0.6)
        let compressedJPGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
        
        
        
        
        let alert = UIAlertView(title: "Wow",
                                message: "Your image was not saved (Yet.....)",
                                delegate: nil,
                                cancelButtonTitle: "Ok")
        alert.show()
    
    }
    
    //Gamera Stuff
    @IBAction func takePhotoPressed(sender: UIButton) {
        
        print("in the funk")
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            print("thing available")
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func choosePhotoPressed(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            imagePicker.allowsEditing = true
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        imagePicked.image = image
        
        
        
        // Save image to Document directory
        var imagePath = NSDate().description
        imagePath = imagePath.stringByReplacingOccurrencesOfString(" ", withString: "")
        let imagePath2 = ImageBank.sharedInstance.imagesDirectoryPath.stringByAppendingString("/\(imagePath).png")///this is the problem
       
        print("ImageName from intro controller: \(imagePath)")
        print("ImagePath from intro controller: \(imagePath2)")
        let data = UIImagePNGRepresentation(image)
        
     
        let success = NSFileManager.defaultManager().createFileAtPath(imagePath2, contents: data, attributes: nil)
        if success{
            let tempImagePath = PhotoName(photoName: imagePath)
            ImageBank.sharedInstance.appPhotoNamesArray.append(tempImagePath!)//this should let me get app photos elsewhere
            ImageBank.sharedInstance.savePhotoNames()
        }else{
            print("Warning Photo not stored")
        }
        dismissViewControllerAnimated(true) { () -> Void in
  
        }
        
        
        
        
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
}
