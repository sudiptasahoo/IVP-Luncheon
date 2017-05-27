//
//  SSLocationService.swift
//  IVP Luncheon
//
//  Created by Sudipta Sahoo on 24/05/17.
//  Copyright © 2017 Sudipta Sahoo <dev@sudiptasahoo.in>. This file is part of Indus Valley Partners interview process. This file can not be copied and/or distributed without the express permission of Sudipta Sahoo. All rights reserved.
//

import UIKit
import CoreLocation

class SSLocationService: NSObject {

    static let shared = SSLocationService()
    let locationManager = CLLocationManager() // Add this statement
    
    override init() {
        super.init()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
}


extension SSLocationService : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("didChangeAuthorization \(status.rawValue)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager failed with the following error: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let latestLocation = locations[0]
        print("didUpdateLocations with accuracy \(latestLocation.horizontalAccuracy)")

        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            if (error != nil) {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            
            if (placemarks?.count)! > 0 {
                let pm = placemarks?[0]
                self.displayLocationInfo(pm!)
            } else {
                print("Problem with the data received from geocoder")
            }
        })
        
        //Start Monitoring
        self.startMonitoring(location: latestLocation)
        
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("Monitoring failed for region with identifier: \(region!.identifier)")
    }

    func displayLocationInfo(_ placemark: CLPlacemark) {
        if placemark != nil {
            //stop updating location to save battery life
            //locationManager.stopUpdatingLocation()
            print(placemark.locality ?? "")
            print(placemark.postalCode ?? "")
            print(placemark.administrativeArea ?? "")
            print(placemark.country ?? "")
        }
    }
    
    //Geo Fence Related delegates
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("didEnterRegion")
        if region is CLCircularRegion {
            handleEvent(forRegion: region)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("didExitRegion")
        if region is CLCircularRegion {
            handleEvent(forRegion: region)
        }
    }
    
}

extension SSLocationService{
    
    func region(withCoordinate coordinate: CLLocationCoordinate2D, radius: CLLocationDistance, identifier: String) -> CLCircularRegion {
        let region = CLCircularRegion(center: coordinate, radius: radius, identifier: identifier)
        region.notifyOnEntry = true
        region.notifyOnExit = false
        return region
    }
    
    func startMonitoring(location: CLLocation) {

        if !CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            print("Geofencing is not supported on this device!")
            return
        }

        if CLLocationManager.authorizationStatus() != .authorizedAlways {
            print("Your geotification is saved but will only be activated once you grant Geotify permission to access the device location.")
        }

        
        let region = self.region(withCoordinate: location.coordinate, radius: 100, identifier: "ivp_luncheon_geofence")

        locationManager.startMonitoring(for: region)
    }
    
    func stopUpdatingLocation() {
        for region in locationManager.monitoredRegions {
            guard let circularRegion = region as? CLCircularRegion, circularRegion.identifier == "ivp" else { continue }
            locationManager.stopMonitoring(for: circularRegion)
        }
    }
    
    func handleEvent(forRegion region: CLRegion!) {
        print("Geofence triggered!")
    }
}



