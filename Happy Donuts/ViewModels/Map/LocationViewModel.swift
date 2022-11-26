//
//  MapViewModel.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 25-11-22.
//

import Foundation
import CoreLocation
import MapKit
import SwiftUI

final class LocationViewModel: NSObject, ObservableObject {
    
    @Published var userHasLocation: Bool = false
    @Published var userLocation: MKCoordinateRegion = .init()
    private let locationManager: CLLocationManager = .init()
    
    private struct DefaultRegion {
        static let latitude = -33.47
        static let longitude = -70.64
    }
    
    private struct Span {
        static let delta = 0.01
        static let deltaDefault = 2.0
    }
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        userLocation = .init(center: .init(latitude: DefaultRegion.latitude, longitude: DefaultRegion.longitude), span: .init(latitudeDelta: Span.deltaDefault, longitudeDelta: Span.deltaDefault))
    }
    
    func checkUserAuthorization() {
        let status = locationManager.authorizationStatus
        switch status {
        case .notDetermined, .restricted, .denied:
            self.userHasLocation = false
        case .authorizedAlways, .authorizedWhenInUse:
            self.userHasLocation = true
        @unknown default:
            print("Unhandel locatin state")
        }
    }
}

extension LocationViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        print("Location: \(location)")
        userLocation = .init(center: location.coordinate, span: .init(latitudeDelta: Span.delta, longitudeDelta: Span.delta))
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserAuthorization()
    }
}

