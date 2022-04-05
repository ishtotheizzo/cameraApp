//
//  eventLocationApp.swift
//  eventLocation
//  eventList JSON based off of JSON from Hacking with Swift, iDine Project 
//  Created by meh  on 3/19/22.
//

import SwiftUI

@main
struct eventLocationApp: App {
    
    //@StateObject var userLocation = ""
    @StateObject private var userLocation = locationManager()
    @StateObject private var cityStore = CityStore()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationManager())
                .environmentObject(CityStore())
        }
    }
}
