//
//  JournalMapViewController.swift
//  ProtoTwo
//
//  Created by Don on 2016-12-16.
//  Copyright © 2016 Don. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class JournalMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var eventArray = [JournalEntry]()
    
    lazy var locationManager: CLLocationManager = {
        var _locationManager = CLLocationManager()
        _locationManager.delegate = self
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest
        _locationManager.activityType = .Fitness
        // _locationManager.allowsBackgroundLocationUpdates = true
        
        // Movement threshold for new events
        _locationManager.distanceFilter = 1.0
        return _locationManager
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestAlwaysAuthorization()
        
        
        addAnnotationToMap()
        
        
        
        
        printLocations()
        
    }
    
    func printLocations(){
    
        for j in eventArray{
            print(j.latt)
            print(j.long)
            addRadiusOverlayForJournalEntry(j)
        }
    }
    
    func addAnnotationToMap() {
        
        for j in eventArray{
            mapView.addAnnotation(j)
            addRadiusOverlayForJournalEntry(j)
        }
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
    
    // MARK: MKMapViewDelegate
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "myNotification"
        //print("Macaroni")
        if annotation is JournalEntry {
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                let removeButton = UIButton(type: .Custom)
                removeButton.frame = CGRect(x: 0, y: 0, width: 23, height: 23)
                removeButton.setImage(UIImage(named: "DeleteGeotification")!, forState: .Normal)
                annotationView?.leftCalloutAccessoryView = removeButton
                //annotationView?.title = annotation.title
                //let btn = UIButton(type: .DetailDisclosure)
                //annotationView?.rightCalloutAccessoryView = btn
                //print("Jeez")
                
            } else {
                annotationView?.annotation = annotation
                //print("louise")
            }
            return annotationView
        }
        return nil
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer! {
        if overlay is MKCircle {
            let circleRenderer = MKCircleRenderer(overlay: overlay)
            circleRenderer.lineWidth = 1.0
            circleRenderer.strokeColor = UIColor.purpleColor()
            circleRenderer.fillColor = UIColor.purpleColor().colorWithAlphaComponent(0.4)
            
            return circleRenderer
        }
        
        return nil
        
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay, color: UIColor) -> MKOverlayRenderer! {
        if overlay is MKCircle {
            let circleRenderer = MKCircleRenderer(overlay: overlay)
            circleRenderer.lineWidth = 1.0
            circleRenderer.strokeColor = color
            circleRenderer.fillColor = UIColor.purpleColor().colorWithAlphaComponent(0.4)
            return circleRenderer
        }
        return nil
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        print("Thing Tapped")
        //        // Delete geotification
        //        let geotification = view.annotation as! Geotification
        //        stopMonitoringGeotification(geotification)
        //        removeGeotification(geotification)
        //        saveAllGeotifications()
    }
    
    // MARK: Map overlay functions
    
    func addRadiusOverlayForJournalEntry(journalEntry: JournalEntry) {
        mapView?.addOverlay(MKCircle(centerCoordinate: journalEntry.coordinate, radius: journalEntry.radius))
        //mapView?.addOverlay(MKCircle(centerCoordinate: geotification.coordinate, radius: geotification.bufferRadius))
    }
    
    func removeRadiusOverlayJournalEntry(notification: Notification) {
        // Find exactly one overlay which has the same coordinates & radius to remove
        if let overlays = mapView?.overlays {
            for overlay in overlays {
                if let circleOverlay = overlay as? MKCircle {
                    let coord = circleOverlay.coordinate
                    if coord.latitude == notification.coordinate.latitude && coord.longitude == notification.coordinate.longitude && circleOverlay.radius == notification.radius {
                        mapView?.removeOverlay(circleOverlay)
                        break
                    }
                }
            }
        }
    }
    // MARK: Other mapview functions
    
    @IBAction func zoomToCurrentLocation(sender: AnyObject) {
        zoomToUserLocationInMapView(mapView)
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        mapView.showsUserLocation = (status == .AuthorizedAlways)
    }
    
    
}


