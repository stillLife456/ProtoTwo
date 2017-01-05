//
//  CostVsBenefitViewController.swift
//  ProtoTwo
//
//  Created by Don on 2016-08-20.
//  Copyright © 2016 Don. All rights reserved.
//

import UIKit

protocol CostBenefitViewControllerDelegate : class {
    
    func costBenefitVCDismissed(feeling : String?)
}

class CostVsBenefitViewController: UIViewController {

    @IBOutlet weak var whataView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
     }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated) // No need for semicolon
//                let costBenSheet = CostBenefitSheet(nibName: "CostBenefitSheet", bundle: nil) as CostBenefitSheet
//                costBenSheet.modalPresentationStyle = .overCurrentContext
//                present(costBenSheet, animated: false, completion: nil)
//                print("Geez Louise")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

