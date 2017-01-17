//
//  IntroSurveyViewController.swift
//  ProtoTwo
//
//  Created by Don on 2017-01-14.
//  Copyright © 2017 Don. All rights reserved.
//



import UIKit


class IntroSurveyViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var numSmokesDayInputField: UITextField!
    
    @IBOutlet weak var timeAfterWaking: UITextField!

    
    @IBOutlet weak var doneButton: UIButton!
    
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
       
    
    }
}