//
//  MapOverviewViewController.swift
//  ProtoTwo
//
//  Created by Don on 2016-11-30.
//  Copyright © 2016 Don. All rights reserved.
//

import UIKit
import MapKit

class MapOverviewViewController: UIViewController {
    
    
    
    
    
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
    
//            getJournalLocations()
//            zoomToFitMapAnnotations(mapView)
        }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

//    @IBOutlet weak var mapView: MKMapView!
//    
//    
//    //MARK: Properties
//    let defaultRadius = 10.0
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        getJournalLocations()
//        zoomToFitMapAnnotations(mapView)
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    func getJournalLocations () {
//        for e in Journal.sharedInstance.journalArray {
//            if e.title != "Quit Day"{
//                mapView.addAnnotation(e)
//                addRadiusOverlayForNotification(e)
//              
//                print("????????????????????????????????????????????")
//                print("Ffound journal entry")
//            }
//        }
//
//    }
//    
//
//    // MARK: MKMapViewDelegate
//    
//    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
//        let identifier = "myEntry"
//       // let identifier2 = "myEntry2"
//        //print("Macaroni")
//        if annotation is JournalEntry {
//            
//            //if annotation.
//            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView
//            if annotationView == nil {
//                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//                annotationView?.canShowCallout = true
//                let removeButton = UIButton(type: .Custom)
//                removeButton.frame = CGRect(x: 0, y: 0, width: 23, height: 23)
//                removeButton.setImage(UIImage(named: "DeleteEntry")!, forState: .Normal)
//                annotationView?.leftCalloutAccessoryView = removeButton
//                //let btn = UIButton(type: .DetailDisclosure)
//                //annotationView?.rightCalloutAccessoryView = btn
//                //print("Jeez")
//                
//            } else {
//                annotationView?.annotation = annotation
//                //print("louise")
//            }
//            return annotationView
//        }
//        return nil
//    }
//    
//    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer! {
//        if overlay is MKCircle {
//            let circleRenderer = MKCircleRenderer(overlay: overlay)
//            circleRenderer.lineWidth = 1.0
//            circleRenderer.strokeColor = UIColor.purpleColor()
//            circleRenderer.fillColor = UIColor.purpleColor().colorWithAlphaComponent(0.4)
//            
//            return circleRenderer
//        }
//        
//        return nil
//        
//    }
//    
//    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay, color: UIColor) -> MKOverlayRenderer! {
//        if overlay is MKCircle {
//            let circleRenderer = MKCircleRenderer(overlay: overlay)
//            circleRenderer.lineWidth = 1.0
//            circleRenderer.strokeColor = color
//            circleRenderer.fillColor = UIColor.purpleColor().colorWithAlphaComponent(0.4)
//            return circleRenderer
//        }
//        return nil
//    }
//    
//    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        
//        print("Thing Tapped")
//        //        // Delete geotification
//        //        let geotification = view.annotation as! Geotification
//        //        stopMonitoringGeotification(geotification)
//        //        removeGeotification(geotification)
//        //        saveAllGeotifications()
//    }
//    
//    // MARK: Map overlay functions
//    
//    func addRadiusOverlayForNotification(journalEntry: JournalEntry) {
//        mapView?.addOverlay(MKCircle(centerCoordinate: journalEntry.coordinate, radius: defaultRadius))
//        //mapView?.addOverlay(MKCircle(centerCoordinate: geotification.coordinate, radius: geotification.bufferRadius))
//    }
//    
//    func removeRadiusOverlayForNotification(notification: Notification) {
//        // Find exactly one overlay which has the same coordinates & radius to remove
//        if let overlays = mapView?.overlays {
//            for overlay in overlays {
//                if let circleOverlay = overlay as? MKCircle {
//                    let coord = circleOverlay.coordinate
//                    if coord.latitude == notification.coordinate.latitude && coord.longitude == notification.coordinate.longitude && circleOverlay.radius == notification.radius {
//                        mapView?.removeOverlay(circleOverlay)
//                        break
//                    }
//                }
//            }
//        }
//    }
//    // MARK: Other mapview functions
//    
//    @IBAction func zoomToCurrentLocation(sender: AnyObject) {
//        zoomToUserLocationInMapView(mapView)
//    }
//    
//    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
//        mapView.showsUserLocation = (status == .AuthorizedAlways)
//    }
//    
//    func zoomToFitMapAnnotations(aMapView: MKMapView) {
//        guard aMapView.annotations.count > 0 else {
//            return
//        }
//        var topLeftCoord: CLLocationCoordinate2D = CLLocationCoordinate2D()
//        topLeftCoord.latitude = -90
//        topLeftCoord.longitude = 180
//        var bottomRightCoord: CLLocationCoordinate2D = CLLocationCoordinate2D()
//        bottomRightCoord.latitude = 90
//        bottomRightCoord.longitude = -180
//        for annotation: MKAnnotation in aMapView.annotations {
//            topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude)
//            topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude)
//            bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude)
//            bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude)
//        }
//        
//        var region: MKCoordinateRegion = MKCoordinateRegion()
//        region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5
//        region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5
//        region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.4
//        region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.4
//        region = aMapView.regionThatFits(region)
//        aMapView.setRegion(region, animated: true)
//    }
    
//    func zoom(toFitMapAnnotations aMapView: MKMapView) {
//        if aMapView.annotations.count == 0 {
//            return
//        }
//        var topLeftCoord = CLLocationCoordinate2D(latitude: -90, longitude: 180)
////        topLeftCoord.latitude = -90
////        topLeftCoord.longitude = 180
//        var bottomRightCoord = CLLocationCoordinate2D(latitude: 90, longitude: -180)
////        bottomRightCoord.latitude = 90
////        bottomRightCoord.longitude = -180
//        for annotation: MKAnnotation in mapView.annotations {
//            topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude)
//            topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude)
//            bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude)
//            bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude)
//        }
//        var region = MKCoordinateRegion()
//        region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5
//        region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5
//        region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.1
//        // Add a little extra space on the sides
//        region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.1
//        // Add a little extra space on the sides
//        region = aMapView.regionThatFits(region)
//        mapView.setRegion(region, animated: true)
//    
//    
//}
}


