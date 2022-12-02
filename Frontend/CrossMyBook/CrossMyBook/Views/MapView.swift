//
//  MapView.swift
//  CrossMyBook
//
//  Created by Femin Dharamshi on 12/2/22.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
  
  var mapRegion: MKCoordinateRegion
  var travelPoints: [TravelHistory]
  
  init(mapRegion: MKCoordinateRegion, travelPoints: [TravelHistory]) {
    self.mapRegion = mapRegion
    self.travelPoints = travelPoints
  }
  
  func makeCoordinator() -> MapCoordinator {
          MapCoordinator(self)
      }
  
  func updateUIView(_ view: MKMapView, context: UIViewRepresentableContext<MapView>) {
    view.setRegion(mapRegion, animated: true)
    
    var locationList: [CLLocationCoordinate2D] = []
    
    for travelPoint in travelPoints {
      let droppedPin = MKPointAnnotation()
         droppedPin.coordinate = CLLocationCoordinate2D(
          latitude: travelPoint.lat, // fill in with your current location latitude ,
          longitude: travelPoint.lon// fill in with your current location longitude
         )
      droppedPin.title = travelPoint.user
      view.addAnnotation(droppedPin)
      
      locationList.append(CLLocationCoordinate2D(
        latitude: travelPoint.lat, // fill in with your current location latitude ,
        longitude: travelPoint.lon// fill in with your current location longitude
       ))
    }
    
    let polyline = MKPolyline(coordinates: locationList, count: locationList.count)
    view.addOverlay(polyline)
  }

  func makeUIView(context: Context) -> MKMapView {
    let mapView = MKMapView(frame: .zero)
    mapView.delegate = context.coordinator
    var locationList: [CLLocationCoordinate2D] = []
    
    for travelPoint in travelPoints {
      let droppedPin = MKPointAnnotation()
         droppedPin.coordinate = CLLocationCoordinate2D(
          latitude: travelPoint.lat, // fill in with your current location latitude ,
          longitude: travelPoint.lon// fill in with your current location longitude
         )
      droppedPin.title = travelPoint.user
      mapView.addAnnotation(droppedPin)
      
      locationList.append(CLLocationCoordinate2D(
        latitude: travelPoint.lat, // fill in with your current location latitude ,
        longitude: travelPoint.lon// fill in with your current location longitude
       ))
    }
    
    let polyline = MKPolyline(coordinates: locationList, count: locationList.count)
    mapView.addOverlay(polyline)
    
    return mapView
  }
  
  final class MapCoordinator: NSObject, MKMapViewDelegate {
      // 1.
      var parent: MapView

      init(_ parent: MapView) {
          self.parent = parent
      }
      

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {

        if let routePolyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: routePolyline)
          renderer.strokeColor = UIColor.black.withAlphaComponent(0.5)
            renderer.lineWidth = 4
            return renderer
        }

        return MKOverlayRenderer()
    }
      
  }
  
}
