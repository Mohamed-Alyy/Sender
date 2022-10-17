//
//  LocationHelper.swift
//  SupportI
//
//  Created by mohamed abdo on 9/2/19.
//  Copyright © 2019 MohamedAbdu. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

typealias OnUpdateLocation = ((CLLocationCoordinate2D?) -> Void)
typealias OnErrorLocation = (() -> Void)

protocol LocationDelegate: class {
    func didUpdateLocation(lat: Double, lng: Double)
    func didErrorLocation()
}
extension LocationDelegate {
    func didUpdateLocation(lat: Double, lng: Double) {}
    func didErrorLocation() {}
}
class LocationHelper: NSObject {
    private var locationManager: CLLocationManager!
    private var locationUpdated: Bool = false
    private weak var _delegate: LocationDelegate?

    var useInBackground: Bool = false
    var updateLocationInDistance: Double?
    var useOnlyoneTime: Bool = true
    var delegate: LocationDelegate? {
        set {
            _delegate = newValue
        } get {
            return _delegate
        }
    }
    var onUpdateLocation: OnUpdateLocation?
    var onErrorLocation: OnErrorLocation?
    /* currentLocation */
    var location: CLLocation?
    var degree: CLLocationCoordinate2D? {
        return location?.coordinate
    }
    var lat: Double? {
        return location?.coordinate.latitude
    }
    var lng: Double? {
        return location?.coordinate.longitude
    }
    override init() {
        super.init()
        self.locationManager = CLLocationManager()
    }
    public func reload() {
        self.locationUpdated = false
        self.currentLocation()
    }
}

/** part of location **/
extension LocationHelper: CLLocationManagerDelegate {
    public func currentLocation() {
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
                case .restricted, .denied:
                    self.onErrorLocation?()
                default:
                    break
            }
            if updateLocationInDistance == nil {
                locationManager.distanceFilter = kCLDistanceFilterNone
            } else {
                locationManager.distanceFilter = updateLocationInDistance ?? 0
            }
            if useInBackground {
                locationManager.allowsBackgroundLocationUpdates = true
                //locationManager.showsBackgroundLocationIndicator = true
            }
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            locationManager.delegate = self
        } else {
            self.onErrorLocation?()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0] as CLLocation // note that locations is same as the one in the function declaration
        self.location = userLocation
        self.delegate?.didUpdateLocation(lat: self.lat ?? 0, lng: self.lng ?? 0)
        self.onUpdateLocation?(self.degree)
        if useOnlyoneTime {
            manager.stopUpdatingLocation()
            locationManager.stopUpdatingLocation()
            if !locationUpdated {
                /** set current location */
                locationUpdated = true
            }
        }
    }
}

extension LocationHelper {
    func pointDistance(from: CLLocation, to: CLLocation) -> Double {
        var distance = to.distance(from: from)
        distance /= 1000
        if distance > 99 {
            distance = 99
        }
        return distance.decimal(1).double() ?? 0
    }
}
