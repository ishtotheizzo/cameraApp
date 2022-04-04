//
//  locationManager.swift
//  eventLocation
//
//  Created by meh  on 3/19/22.
//  Base Code created by Loren Olson 

import Foundation
import CoreLocation
import SwiftUI
import MapKit

class locationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @EnvironmentObject var cityStore: CityStore
    
    //taken from loren olson's code
    
    let userLocation: CLLocationManager
    
    @Published var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 33.43200654654474, longitude: -111.9426764465573), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    
    
    
    
    var sourceCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 33.43200654654474, longitude: -117.919006)
    var destinationCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 33.812029, longitude: -117.919006)
    
    var sourceMapItem: MKMapItem?
    var destinationMapItem: MKMapItem?
    
    var routePolyline: MKPolyline?
    
    override init()
    {
        userLocation = CLLocationManager()
        
        super.init()
        userLocation.delegate = self
        userLocation.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func start()
    {
        userLocation.startUpdatingLocation()
    }
    

    func getPermission()
    {
        userLocation.requestWhenInUseAuthorization()

    }
    // get user locations
    func getLocation()
    {
        userLocation.requestLocation()
      
    }

    func stop()
    {
        userLocation.stopUpdatingLocation()
    }
    
    
    
    
    // taken from loren olson's code
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let newLocation = locations.first {
            region.center = newLocation.coordinate
            print(newLocation.coordinate)
        }
        // stop the updates to save battery
        stop()
    }
    
    
    //handle coordinates
    // code from
    
 
    
    // code from: https://medium.com/devtechie/new-in-swiftui-and-ios-15-locationbutton-1737710e26df
    // since this is in a simulator, it's always going to deny the permissions so it's always going to throw the error "The operation couldn’t be completed. (kCLErrorDomain error 1.)
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    
    
    
    // find eta
    
   

    
    //  THE BELOW CODE IS WRITTEN BY LOREN OLSON 
    

   
   // just use this one we have locationA and locationB
    
    func route(Lats: Double, Longs: Double) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: region.center.latitude, longitude: region.center.longitude)))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: Lats, longitude: Longs)))
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate(completionHandler: {(response: MKDirections.Response?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let response = response {
                print("Found \(response.routes.count) routes.")
                guard response.routes.count > 0 else { return }
                var routes = response.routes
                routes.sort(by: {$0.expectedTravelTime < $1.expectedTravelTime})
                let route = routes[0]

                self.routePolyline = route.polyline
                self.region.center = self.destinationCoordinate
                return
            }
        })
    }
}
