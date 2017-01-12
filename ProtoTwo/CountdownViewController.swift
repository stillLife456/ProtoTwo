//
//  CountdownViewController.swift
//  ProtoOne
//
//  Created by Don on 2016-08-08.
//  Copyright © 2016 Don. All rights reserved.
//

import Foundation
import UIKit
import CountdownLabel
import LTMorphingLabel


class CountdownViewController: UIViewController {
    
    @IBOutlet weak var countdownLabel: CountdownLabel!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var upArrow: UIButton!
    @IBOutlet weak var downArrow: UIButton!
    
    
    
    //Properties
    var countDownTime: Double = 0.1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //countdownLabel.delegate = self
        setupCountdown()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        print("The view was refreshed")
        setupCountdown()
    }
    
    
    
    //    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
    //        if keyPath == "text" {
    //            print("Please please please")
    //        }
    //    }
    
    
    func setupCountdown() {
        countdownLabel.setCountDownTime(countDownTime*60)
        countdownLabel.animationType = .Burn
        countdownLabel.timeFormat = "mm:ss"
        countdownLabel.then(59){
            self.countdownLabel.textColor = .greenColor()
        }
        countdownLabel.then(49){
            self.countdownLabel.textColor = .redColor()
        }
        countdownLabel.then(1) {
            //self.alert("You're done!!")
            print("Countdown reached zero")
            ///
            //self.performSegueWithIdentifier("JournalNavSegue", sender: self)
            // self.tabBarController?.selectedIndex = 1
        }
        
        countdownLabel.start()
        countdownLabel.pause()
    }
    
    func refreshCountdownTime() {
        countdownLabel.setCountDownTime(countDownTime*60)
    }
    
    @IBAction func startTimer(sender: UIButton){
        
        
        
        if countdownLabel.isPaused{
            sender.setTitle("Start", forState: .Normal)
            countdownLabel.start()
        } else {
            sender.setTitle("Pause", forState: .Normal)
            countdownLabel.pause()
        }
        
    }
    
    @IBAction func arrowTapped(sender: UIButton) {
        
        if sender == upArrow {
            countDownTime = countDownTime + 1
            
        }
        if sender == downArrow {
            countDownTime = countDownTime - 1
            
        }
        refreshCountdownTime()
    }
    //    // delegate
    //    func countingAt(timeCounted timeCounted: NSTimeInterval, timeRemaining: NSTimeInterval) {
    //        switch timeRemaining {
    //        case 60:
    //            countdownLabel.animationType = .Fall
    //            countdownLabel.textColor = .redColor()
    //        case 45:
    //
    //            countdownLabel.textColor = .orangeColor()
    //        case 30:
    //            countdownLabel.textColor = .yellowColor()
    //
    //        case 20:
    //            countdownLabel.animationType = .Burn
    //            countdownLabel.textColor = .redColor()
    //        case 5:
    //            self.countdownLabel.animationType = .Sparkle
    //            self.countdownLabel.textColor = .greenColor()
    //        default:
    //            break
    //        }
    //    }
    
    //
    //    func loadYoutube(videoID videoID:String) {
    //        // create a custom youtubeURL with the video ID
    //        guard
    //            let youtubeURL = NSURL(string: "https://www.youtube.com/embed/\(videoID)")
    //            else { return }
    //        // load your web request
    //        webView.loadRequest( NSURLRequest(URL: youtubeURL) )
    //    }
    
    
}
extension CountdownViewController: CountdownLabelDelegate /* LTMorphingLabelDelegate */{
    func countdownFinished() {
        debugPrint("countdownFinished at delegate.")
    }
    
    func countingAt(timeCounted timeCounted: NSTimeInterval, timeRemaining: NSTimeInterval) {
        print("time counted at delegate=\(timeCounted)")
        //debugPrint("time remaining at delegate=\(timeRemaining)")
        
        func monitorTime () {
            while countdownLabel.isCounting{
                print("Bullshit")
            }
        }
        
    }
    
    
}

extension CountdownViewController {
    func alert(title: String) {
        let vc = UIAlertController(title: title, message: nil, preferredStyle: .Alert)
        vc.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(vc, animated: true, completion: nil)
    }
}
