//
//  LocationSearchViewModel.swift
//  Uber-SwiftUI (iOS)
//
//  Created by Bhoopendra Umrao on 4/12/23.
//

import Foundation
import MapKit

@MainActor
class LocationSearchViewModel: NSObject, ObservableObject {
    
    @Published var result = [MKLocalSearchCompletion]()
    
    @Published var selectedLocation: CLLocationCoordinate2D?
    
    @Published var route: MKRoute?
    
    private let searchCompleter = MKLocalSearchCompleter()
    
    var queryFragment: String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    
    func setRoute(_ route: MKRoute?) {
        self.route = route
    }
    
    func setSelected(_ location: MKLocalSearchCompletion) {
        
        Task {
            let coordinate = await getCoordinate(for: location)
            self.selectedLocation = coordinate
        }
    }
    
    private func getCoordinate(for location: MKLocalSearchCompletion) async -> CLLocationCoordinate2D? {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = location.title.appending(location.subtitle)
        let search = MKLocalSearch(request: request)
        do {
            let result = try await search.start()
            guard let item = result.mapItems.first else {
                return nil
            }
            return item.placemark.coordinate
        } catch {
            print("DEBUG: error")
            return nil
        }
    }
    
    func getDirection(from startLocation: CLLocationCoordinate2D, to destinationLocation: CLLocationCoordinate2D) {
        let startPlacemark = MKPlacemark(coordinate: startLocation)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startPlacemark)
        request.destination = MKMapItem(placemark: destinationPlacemark)
        let route = MKDirections(request: request)
        Task {
            do {
                let response = try await route.calculate()
                self.setRoute(response.routes.first)
    //            return response.routes.first
            } catch {
    //            return nil
                print("DEBUG: Route not found")
            }
        }
    }
}

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        result = completer.results
    }
}
