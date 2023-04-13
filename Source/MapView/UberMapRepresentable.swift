//
//  UberMapRepresentable.swift
//  Uber-SwiftUI (iOS)
//
//  Created by Bhoopendra Umrao on 4/12/23.
//

import SwiftUI
import MapKit

struct UberMapRepresentable: UIViewRepresentable {
    
    let mapView = MKMapView()
    let locationManager = LocationManager()
    @Binding var mapState: MapState
    @EnvironmentObject var searchlocationViewModel: LocationSearchViewModel
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.isRotateEnabled = false
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        switch mapState {
        case .noInput, .locationSearch:
            context.coordinator.clearAnnotationAndRecenter()
        case .locationSelected:
            if let coordinate = searchlocationViewModel.selectedLocation {
                context.coordinator.addAndSelect(coordinate: coordinate)
                if let route = searchlocationViewModel.route {
                    context.coordinator.drawPolyline(forRoute: route)
                } else {
                    context.coordinator.configurePolyline(forDestination: coordinate)
                }
            }
        }
        
    }
    
    func makeCoordinator() -> MapCoordinator {
        MapCoordinator(parent: self)
    }
}

extension UberMapRepresentable {
    class MapCoordinator: NSObject, MKMapViewDelegate {
        let parent: UberMapRepresentable
        var userLocation: CLLocationCoordinate2D?
        var userRegion: MKCoordinateRegion?
        
        init(parent: UberMapRepresentable) {
            self.parent = parent
            super.init()
        }
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocation = userLocation.coordinate
            let userRegion = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            self.userRegion = userRegion
            parent.mapView.setRegion(userRegion, animated: true)
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let polyline = MKPolylineRenderer(overlay: overlay)
            polyline.strokeColor = .systemBlue
            polyline.lineWidth = 6
            return polyline
        }
        
        func addAndSelect(coordinate: CLLocationCoordinate2D) {
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            parent.mapView.addAnnotation(annotation)
            parent.mapView.selectAnnotation(annotation, animated: true)
        }
        
        @MainActor func configurePolyline(forDestination destination: CLLocationCoordinate2D) {
            guard let userLocation = userLocation else {
                return
            }
            parent.searchlocationViewModel.getDirection(from: userLocation, to: destination)
        }
        
        func drawPolyline(forRoute route: MKRoute) {
            parent.mapView.addOverlay(route.polyline)
            let insets = UIEdgeInsets(top: 50, left: 50, bottom: 500, right: 50)
            parent.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: insets, animated: true)
        }
        
        func clearAnnotationAndRecenter() {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            parent.mapView.removeOverlays(parent.mapView.overlays)
            if let region = userRegion {
                parent.mapView.setRegion(region, animated: true)
            }
        }
    }
}

