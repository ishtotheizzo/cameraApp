

//
//  CustomMapView.swift
//  RouteDemo
//
//  Created by Loren Olson on 3/16/22.
//

import SwiftUI
import MapKit

struct CustomMapView: UIViewRepresentable {

    @Binding var region: MKCoordinateRegion
    var polyline: MKPolyline?

    // UIViewRepresentable protocol methods
    
    // Creates the view object and configures its initial state.
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.region = region
        mapView.showsTraffic = true
        mapView.showsUserLocation = true 
        
        if let polyline = polyline {
            print("polyline has a value.")
            mapView.addOverlay(polyline)
        }
        
        return mapView
    }
    
    
    // Updates the state of the specified view with new information from SwiftUI.
    func updateUIView(_ view: MKMapView, context: Context) {
        if let polyline = polyline {
            if view.overlays.count > 0 {
                view.removeOverlays(view.overlays)
            }
            view.setVisibleMapRect(polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0), animated: true)
            view.addOverlay(polyline)
        }
    }

    // Creates the custom instance that you use to communicate changes from your view to other parts of your SwiftUI interface.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

}

class Coordinator: NSObject, MKMapViewDelegate {
    var parent: CustomMapView

    init(_ parent: CustomMapView) {
        self.parent = parent
    }
    
    // MKMapViewDelegate method
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let routePolyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: routePolyline)
            renderer.strokeColor = UIColor.systemBlue.withAlphaComponent(0.75)
            renderer.lineWidth = 6
            return renderer
        }
        return MKOverlayRenderer()
    }
}
