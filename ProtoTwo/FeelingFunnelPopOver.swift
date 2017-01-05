//
//  FeelingFunnelPopOver.swift
//  ProtoTwo
//
//  Created by Don on 2016-10-03.
//  Copyright © 2016 Don. All rights reserved.
//


import Foundation
import UIKit



//internal was public
public class FeelingFunnelPopOver : NSObject, UIPopoverPresentationControllerDelegate, FeelingFunnelViewControllerDelegate {
    
    internal typealias FeelingFunnelCallback = (newFeeling : String, forTextField : UITextField)->()
    
    var feelingFunnelVC : FeelingFunnnelViewController
    var popover : UIPopoverPresentationController?
    var textField : UITextField!
    var feelingChanged : FeelingFunnelCallback?
    var presented = false
    var offset : CGFloat = 8.0
    
    public init(forTextField: UITextField) {
        
        feelingFunnelVC = FeelingFunnnelViewController()
        self.textField = forTextField
        
        super.init()
    }
    
 
    
    //Need to trace the initDate now initFeeling
    func pick(inViewController : UIViewController, initFeeling : String, feelingChanged : FeelingFunnelCallback) {
        
        if presented {
            return  // we are busy
        }
        
        feelingFunnelVC.delegate = self
        feelingFunnelVC.modalPresentationStyle = UIModalPresentationStyle.Popover
        feelingFunnelVC.popoverPresentationController!.delegate = self
        feelingFunnelVC.preferredContentSize = CGSize(width: 300,height: 500)
        //feelingFunnelVC.currentDate = initDate
        
        popover = feelingFunnelVC.popoverPresentationController
        if let _popover = popover {
            
            _popover.sourceView = textField
            _popover.sourceRect = CGRect(x: self.offset,y: textField.bounds.size.height,width: 0,height: 0)
            _popover.delegate = self
            self.feelingChanged = feelingChanged
            inViewController.presentViewController(feelingFunnelVC, animated: true, completion: nil)
            presented = true
        }
    }
    
    //Added UITraitCollection parameter to fix the full screen popover stretch in iPhone 6s and 6s plus - Pramod Joshi
    public func adaptivePresentationStyleForPresentationController(
        controller: UIPresentationController,
        traitCollection: UITraitCollection)
        -> UIModalPresentationStyle {
            return .None
    }
    
    func feelingFunnelVCDismissed(feeling : String?) {
        
        if let _feelingChanged = feelingChanged {
            
            if let _feeling = feeling {
                
                _feelingChanged(newFeeling: _feeling, forTextField: textField)
                
            }
        }
        presented = false
    }
}


