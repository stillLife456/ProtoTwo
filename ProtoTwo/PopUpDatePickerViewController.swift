//
//  PopUpDatePickerViewController.swift
//  ProtoTwo
//
//  Created by Don on 2016-08-30.
//  Copyright © 2016 Don. All rights reserved.
//

import Foundation
import UIKit

protocol DatePickerViewControllerDelegate : class {
    
    func datePickerVCDismissed(date : NSDate?)
}

class PopUpDatePickerViewController: UIViewController {
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var okDateButton: UIButton!
    
    weak var delegate : DatePickerViewControllerDelegate?
    
    var currentDate : NSDate? {
        didSet {
            updatePickerCurrentDate()
        }
    }

    convenience init() {
        self.init(nibName: "PopUpDatePicker", bundle: nil)
        
    }
    
 
    
    private func updatePickerCurrentDate() {
        
        if let _currentDate = self.currentDate {
            if let _datePicker = self.datePicker {
                _datePicker.date = _currentDate
            }
        }
    }
    
    @IBAction func okAction(sender: AnyObject) {
        print("OK PRESSED!!")
        self.dismissViewControllerAnimated(true) {
            
            let nsdate = self.datePicker.date
            self.delegate?.datePickerVCDismissed(nsdate)
            
                    }
    }
    
    override func viewDidLoad() {
        
        updatePickerCurrentDate()
        datePicker.datePickerMode = UIDatePickerMode.Date
        showDefaultQuitDay()
 
    }
    
    func showDefaultQuitDay(){
        let futureDate = NSCalendar.currentCalendar().dateByAddingUnit(
            .Day,
            value: 21,
            toDate: NSDate(),
            options: NSCalendarOptions(rawValue: 0))!
        datePicker.date = futureDate
    }

    
    override func viewDidDisappear(animated: Bool) {
        
        self.delegate?.datePickerVCDismissed(nil)
    }


}

//Should Porbably go in Utilities eventually
extension NSDate {
    
    // -> Date System Formatted Medium
    func ToDateMediumString() -> NSString? {
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle;
        formatter.timeStyle = .NoStyle;
        return formatter.stringFromDate(self)
    }
}
