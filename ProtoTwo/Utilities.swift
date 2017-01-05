//
//  Utilities.swift
//  ProtoOne
//
//  Created by Don on 2016-06-12.
//  Copyright © 2016 Don. All rights reserved.
//

import UIKit
import MapKit

// MARK: Helper Functions

class AlertHelper{
    
    func showSimpleAlertWithTitle(title: String!, message: String, viewController: UIViewController) {
        
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        alert.addAction(action)
        viewController.presentViewController(alert, animated: true, completion: nil)
    }
}

func zoomToUserLocationInMapView(mapView: MKMapView) {
    if let coordinate = mapView.userLocation.location?.coordinate {
        //let coordinate = CLLocationCoordinate2DMake(49.232467, -123.032372 )
        let region = MKCoordinateRegionMakeWithDistance(coordinate, 1000, 1000)
        mapView.setRegion(region, animated: true)
        //print("zoom gets called")
    }
}

//This may be bad coding // Helper to flag method of app launch
struct NotificationLaunch {
    static var flag = false
}

//Keyboard behaviour stuff
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
//    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed
//    {
//        textField.resignFirstResponder()
//        return true
//    }
    
}

