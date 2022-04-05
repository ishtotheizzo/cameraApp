//
//  ContentView.swift
//  eventLocation
//
//  Created by meh  on 3/19/22.
//

import SwiftUI
import MapKit
import PhotosUI


struct ContentView: View {
    
    @EnvironmentObject var userLocation: locationManager
    @EnvironmentObject var cityStore: CityStore

    var filename = ""
    
    // this code was taken from the simple camera app by loren olson
    
    
    // this is the showing modal boolean
    @State private var showingImagePicker = false
    @State var inputImage: UIImage?
    
    
    
    var body: some View{
        VStack{
            VStack{
            
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
            
                VStack{
                     List{
                            ForEach($cityStore.cities) { $eventCity in
                                Section(header: Text(eventCity.city)) {
                                    
                                    ForEach($eventCity.events){
                                        $Event in
                               
                                        Menu(Event.name){
                                            Text("Location \(Event.location)")
                                            Button("Get Directions", action: {
                                                userLocation.route(Lats: Event.locationLat, Longs: Event.locationLong)
                                                
                                            })
                                        
                                            Button("Take a picture!", action: { self.showingImagePicker = true
                                                
                                                let now = Date()
                                                let formatter = DateFormatter()
                                                formatter.dateFormat = "YYYY-MM-dd_HH-mm-ss-SS"
                                                let timestamp = formatter.string(from: now)
                                                var filename = "\(Event.name)_photo_\(timestamp).jpg"
                                                Event.photos.append(filename)
                                                print(filename)
                                            })
                                        
                                        
                                    }
                                }
                            }
                        } .listStyle(GroupedListStyle())
                        .fullScreenCover(isPresented: $showingImagePicker, onDismiss: {
                        guard let photo = inputImage else { return }
                        saveImageToFile(image: photo, filename: filename)}) {
                        ImagePicker(image: self.$inputImage)
                        .edgesIgnoringSafeArea(.all) }
            
                        
                  
                     
    
                
                     }
                    CustomMapView(region: $userLocation.region, polyline: userLocation.routePolyline).onAppear(perform: {
                        userLocation.getPermission()})
                }
                SwiftUI.Group{
                    loadImageFromDocumentDirectory(fileName: filename)

                }
                
            
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

