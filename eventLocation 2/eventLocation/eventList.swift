//
//  eventList.swift
//  eventLocation
//
//  Created by meh  on 3/19/22.
//  Base code from Hacking with Swift, project iDine

import Foundation


struct EventCity:  Codable, Identifiable {
    var id: UUID
    var city: String
    var events: [Event]
}

struct Event: Codable, Equatable, Identifiable {
    var id: String
    var name: String
    var location: String
    var locationLat: Double
    var locationLong: Double


    #if DEBUG
    static let example = Event(id: "2022-03-01", name: "Pokemon Go", location: "Tempe Town Lake", locationLat: 33.43200654654474, locationLong: -111.9426764465573)
    #endif
}

class CityStore: ObservableObject {
    @Published var cities: [EventCity]
    init() {
        cities =  Bundle.main.decode([EventCity].self, from: "eventlist.json")
        

    }
    
    
    
}
