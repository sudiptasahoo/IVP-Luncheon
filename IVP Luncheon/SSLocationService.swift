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
    
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    locationManager.delegate = self
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
    
  }
}


extension SSLocationService : CLLocationManagerDelegate{
  
  
  func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
    guard let aregion = region as? CLBeaconRegion else {
      return
    }
    
    print("Entered region \(aregion)")
    manager.startUpdatingLocation()
  }
  
  func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
    guard let aregion = region as? CLBeaconRegion else {
      return
    }
    
    print("Exited region \(aregion)")
    manager.startUpdatingLocation()
  }
  
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    print("didChangeAuthorization \(status.rawValue)")
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Location Manager failed with the following error: \(error)")
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let latestLocation = locations[0]
    print("didUpdateLocations with accuracy \(latestLocation.horizontalAccuracy)")
    
    
    
    if latestLocation.horizontalAccuracy < 100{
      
      
      
      
      CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
        if (error != nil) {
          print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
          return
        }
        
        if (placemarks?.count)! > 0 {
          let pm = placemarks?[0]
          self.displayLocationInfo(pm!)
          
          //Start Monitoring
          print("stopped updating location")
          self.startMonitoring(location: latestLocation)
          self.save(latestLocation, locality: (pm?.locality)!)
          manager.stopUpdatingLocation()
          
          
        } else {
          print("Problem with the data received from geocoder")
        }
      })
    }
    
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
  
  func save(_ location: CLLocation, locality: String){
    SSLocationUtility.saveUpdatedCoordinate(lat: String(location.coordinate.latitude), long: String(location.coordinate.longitude), accuracy: String(location.horizontalAccuracy), locality: locality)
  }
}



