//
//  JournalViewController.swift
//  ProtoTwo
//
//  Created by Don on 2016-07-01.
//  Copyright © 2016 Don. All rights reserved.
//

import Foundation
import UIKit
import EventKit
import JTAppleCalendar
import KMPlaceholderTextView
import AVFoundation
import SwiftyJSON
import CoreLocation


class JournalViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate, CLLocationManagerDelegate {
    
    // Outlets
    @IBOutlet weak var noteInputField: KMPlaceholderTextView!
    @IBOutlet weak var wolfWords: UILabel!
   // @IBOutlet weak var journalImage: UIImageView!
    @IBOutlet weak var successButton: UIButton!
    @IBOutlet weak var failureButton: UIButton!
    
    
    @IBOutlet weak var cravingSlider: UISlider!
    @IBOutlet weak var cravingSliderTextField: UITextField!
    @IBOutlet weak var cravingLabel: UILabel!
    
    
    @IBOutlet weak var feelingFunnelLabel: UILabel!
    @IBOutlet weak var feelingFunnelTextOne: UITextField!
    //@IBOutlet weak var feelingFunnelTextTwo: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var smokingSwitch: SmokingSegmentedControl!
    @IBOutlet weak var okayButton: UIButton!
    @IBOutlet weak var locationSwitch: UISwitch!
    @IBOutlet weak var locationLabel: UILabel!
    
    //Properties
    
    var feelingFunnelPopOver: FeelingFunnelPopOver?
    
    //Sound Properties
    var howl : AVAudioPlayer?
    var happyBark : AVAudioPlayer?
    var whimper : AVAudioPlayer?
    
    //Image Properties
    var badWlf = UIImage()
    var goodWlf = UIImage()
    var neutralWlf = UIImage()
    var wolfSize = CGSize(width: 30,height: 30)
    
    //Location Stuff
    let locationManager = CLLocationManager()
    
    var journalLatt = 0.0
    var journalLong = 0.0
    
    //To set up audio player for wolf sounds
    func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer?  {
        //1
        let path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
        let url = NSURL.fileURLWithPath(path!)
        
        //2
        var audioPlayer:AVAudioPlayer?
        
        // 3
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: url)
        } catch {
            print("Player not available")
        }
        
        return audioPlayer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteInputField.delegate = self
        self.hideKeyboardWhenTappedAround()
        loadImages()
        loadSounds()
        setText()
        
        // Saki Edited
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(JournalViewController.suceedchosen(_:)), name: "suceedPressed", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(JournalViewController.failchosen(_:)), name: "failPressed", object: nil)
    
       // sillyMath()
        
        cravingSliderTextField.text = "\(Int(cravingSlider.value))"
        setUpScrollView()
        
        //Set up Popover
        setUpPopOver()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        //smokingSwitch.
        
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            noteInputField.resignFirstResponder()
            return false
        }
        return true
    }


    
    func setUpPopOver() {
        
        feelingFunnelPopOver = FeelingFunnelPopOver(forTextField: feelingFunnelTextOne)
        feelingFunnelTextOne.delegate = self
        feelingFunnelTextOne.addTarget(self, action: #selector(JournalViewController.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingDidEnd)
    
//        feelingFunnelPopOver2 = FeelingFunnelPopOver(forTextField: feelingFunnelTextTwo)
//        feelingFunnelTextTwo.delegate = self
//        feelingFunnelTextTwo.addTarget(self, action: #selector(JournalViewController.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingDidEnd)
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        if (textField === feelingFunnelTextOne) {
            resign()
            
            let initFeeling : String? = " TempyTemp"//
            let feelingChangedCallback : FeelingFunnelPopOver.FeelingFunnelCallback = { (newFeeling : String, forTextField : UITextField) -> () in
                
                // here we don't use self (no retain cycle)
                forTextField.text = newFeeling
//                print("Help Me!!")
//                print(newFeeling)
                
            }
            
            feelingFunnelPopOver!.pick(self, initFeeling: initFeeling!, feelingChanged: feelingChangedCallback)

            
            
            return false
        }
        else {
            return true
        }
    }
    
    func textFieldDidChange(textField: UITextField) {
        print("QuitDay Chosen")
    }
    
    
   
    
    func resign() {
        
        feelingFunnelTextOne.resignFirstResponder()
        
    }

    
    //Set up scroll view ( I Hope!)
    func setUpScrollView () {
        
        self.view .addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(cravingLabel)
        containerView.addSubview(cravingSlider)
        containerView.addSubview(cravingSliderTextField)
        containerView.addSubview(feelingFunnelLabel)
        containerView.addSubview(feelingFunnelTextOne)
        //containerView.addSubview(feelingFunnelTextTwo)
        containerView.addSubview(wolfWords)
        containerView.addSubview(noteInputField)
        containerView.addSubview(smokingSwitch)
        containerView.addSubview(okayButton)
        
        
        
    
    
    }
//    
//    func sillyMath () {
//        
//        //[UIApplication sharedApplication].statusBarFrame.size.height
//        let statBar = UIApplication.sharedApplication().statusBarFrame.size.height
//        let navBar = self.navigationController!.navigationBar.frame.size.height
//        let answer = statBar + navBar
//        print("Ta Da! its: \(answer)")
//    }
    
    func setText(){
        wolfWords.text = "What's on your mind?"
        //successButton.setTitle("Success", forState: UIControlState.Normal)
        //failureButton.setTitle("Failure", forState: UIControlState.Normal)
        
    }
    
    func loadSounds () {
        if let howl = self.setupAudioPlayerWithFile("wolf6", type:"mp3") {
            
            self.howl = howl
            self.howl?.volume = 0.3
        }
        if let happyBark = self.setupAudioPlayerWithFile("dogbark2", type:"mp3") {
            
            self.happyBark = happyBark
            self.happyBark?.volume = 0.3
        }
        if let whimper = self.setupAudioPlayerWithFile("pupwhimper", type:"mp3") {
            
            self.whimper = whimper
            self.whimper?.volume = 0.3
        }
        
    }
    
    func loadImages () {
        setImageStuff()
        if let tempImage = UIImage(named:"goodWolf2"){
            goodWlf = imageResize(tempImage, sizeChange: wolfSize)
        }
        if let tempImage2 = UIImage(named:"crazyWolfHead"){
            badWlf = imageResize(tempImage2, sizeChange: wolfSize)
            
        }
        if let tempImage3 = UIImage(named:"neutralWolf"){
            neutralWlf = imageResize(tempImage3, sizeChange: wolfSize)
        }
       // journalImage.image = neutralWlf
        
//        successButton.setImage(ImageBank.sharedInstance.smokingNo , forState: UIControlState.Normal)
//        failureButton.setImage(ImageBank.sharedInstance.smokingYes , forState: UIControlState.Normal)
    }
    
    func setImageStuff(){
//        let tempSize = journalImage.frame.size
//        wolfSize = tempSize
//        
//        journalImage.contentMode = .ScaleAspectFit
        
    }
    
    func imageResize (image: UIImage, sizeChange:CGSize)-> UIImage{
        
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Use scale factor of main screen
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        image.drawInRect(CGRect(origin: CGPointZero, size: sizeChange))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage
    }
    
    func formatDate (date: NSDate) -> String{
        let dateFormatter = NSDateFormatter()
        //dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
        dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy: HH:mm"
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        let timeStamp = dateFormatter.stringFromDate(date)
        return timeStamp
        
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y -= keyboardSize.height
        }
        
    }
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y += keyboardSize.height
        }
    }
    
    func textView(textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
            
        }
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == UIColor.lightGrayColor() {
            textView.text = ""
            textView.textColor = UIColor.blackColor()
        }
    }
    
    @IBAction func indexChanged(sender : SmokingSegmentedControl) {
        // This all works fine and it prints out the value of 3 on any click
        //print("# of Segments = \(sender.numberOfSegments)")
        
        //sender.
        
        switch sender.selectedIndex {
        case 0:
            print("first segement clicked")
            print("failure button")
        case 1:
            print("second segment clicked")
            print("success button")
        default:
            break;
        }
    } 
    
    @IBAction func wolfTapped(sender: UIButton) {
        
        print("wolf tapped")
        howl?.play()
    }
    
    @IBAction func cravingSliderValueChanged(sender: UISlider){
        print(cravingSlider.value)
        //cravingSliderValueLabel.text = String(cravingSlider.value)
        let currentValue = Int(cravingSlider.value)
        cravingSliderTextField.text = "\(currentValue)"
        cravingSlider.value = Float(currentValue)
        
    }
    
    //Responds to
    @IBAction func journalEvent(sender: UIButton) {
        
        if locationSwitch.on {
            print ("locationSwitch on")
            
        }
        
        if !locationSwitch.on {
            print("Not On")
        }
        
        print("idhfiwbuf iuwbiwiuvbwiuvi")
        //Custom Journal Stuff
        var title = noteInputField.text
        var didSmoke = false
        if smokingSwitch.selectedIndex == 1 {
            //title = "success"
            print("success button")
            //journalImage.image = goodWlf
            //wolfWords.text = "Oh Yeah!!"
            happyBark?.play()
        }else if smokingSwitch.selectedIndex == 0 {
            didSmoke = true
            //title = "failure"
            print("failure button")
//            journalImage.image = badWlf
//            wolfWords.text = "Aww.. Geez..."
            whimper?.play()
        }
        let entryTime = NSDate()
        let displayTime = formatDate(entryTime)
        let note = noteInputField.text
        let quitDayFlag = false
        let cravingRating = Int(cravingSlider.value)
        let feelingOne = feelingFunnelTextOne.text!
        let feelingTwo = "placeHolder" //feelingFunnelTextTwo.text!
        let latt = self.journalLatt
        let long = self.journalLong
        
        
        print("Form Journal Creation \(latt)")
        
        let tempEntry = JournalEntry(title: title, entryTime: entryTime, displayTime: displayTime, note: note, quitDayFlag: quitDayFlag, cravingRating: cravingRating, feelingOne: feelingOne, feelingTwo: feelingTwo, latt: latt, long: long, didSmoke: didSmoke)
        Journal.sharedInstance.journalArray.append(tempEntry!)
        Journal.sharedInstance.saveJournalEntries()
        noteInputField.text = nil
//        noteInputField.hidden = true
//        successButton.hidden = true
//        failureButton.hidden = true
        noteInputField.resignFirstResponder()
        locationManager.stopUpdatingLocation()
        self.tabBarController?.selectedIndex = 0
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
       // print("In did update location")
       // print(locValue.longitude)
        
        self.journalLatt = locValue.latitude
        self.journalLong = locValue.longitude
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed
    {
        print("Why doesnt it WORK!!")
        textField.resignFirstResponder()
        return true
    }
    

    // Saki Edited
    func suceedchosen(notification:NSNotification){
        let message = UIAlertController(title: "Resisted", message: "Yay:)", preferredStyle: UIAlertControllerStyle.Alert)
        message.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(message, animated: true, completion: nil)
    }
    
    func failchosen(notification:NSNotification){
        let message = UIAlertController(title: "Slipped", message: "hmmm...:(", preferredStyle: UIAlertControllerStyle.Alert)
        message.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(message, animated: true, completion: nil)
    }
}