//
//  ContentView.swift
//  eventLocation
//
//  Created by meh  on 3/19/22.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @EnvironmentObject var userLocation: locationManager
    @EnvironmentObject var cityStore: CityStore
    
    
    
    var body: some View{
        VStack{
            HStack{
                
            
            Button(action: {
                userLocation.getLocation()
            }) {
                VStack {
                    Image(systemName: "location")
                        .font(.body)
                    Text("Your Location")
                        .font(.body)
                }
                .padding(8.0)
                .foregroundColor(.white)
                .background(Color.gray)
                .cornerRadius(8)
                
                Spacer()
        
                Text("\(userLocation.region.center.latitude) \(userLocation.region.center.longitude)")
                
            }
            }
                VStack{
          
                    
                     List{
                            ForEach($cityStore.cities) { $eventCity in
                                Section(header: Text(eventCity.city)) {
                                    
                                    ForEach($eventCity.events){ $Event in
                                        Menu(Event.name){
                                            Text("Location \(Event.location)")
                                            Button("Get Directions", action: {
                                                userLocation.route(Lats: Event.locationLat, Longs: Event.locationLong)
                                                
                                            })
                                            
                                            Button("Take Picture")

                                        }
                                                           
                                    }
                                }
                            }
                        } .listStyle(GroupedListStyle())
                    CustomMapView(region: $userLocation.region, polyline: userLocation.routePolyline)
                    
                    .onAppear(perform: {
                        userLocation.getPermission()})
                     
                
                }
                                                    
            }
        }
}

    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(locationManager())
            .environmentObject(CityStore())
    }
}

