//
//  LocationFromMapVC.swift
//  Mutsawiq
//
//  Created by M.abdu on 11/5/20.
//  Copyright © 2020 com.Rowaad. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

// MARK: - ...  ViewController - Vars
class LocationFromMapVC: BaseController {
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
   
    var presenter: LocationFromMapPresenter?
    var router: LocationFromMapRouter?
    var locationHelper: LocationHelper?
    var googleHelper: GoogleMapHelper?
    weak var delegate: LocationFromMapDelegateContract?
    var lat: Double?
    var lng: Double?
    var snippetAddress: String?
}

// MARK: - ...  LifeCycle
extension LocationFromMapVC {
    override func viewDidLoad() {
        super.hideNav = true
        super.viewDidLoad()
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter = .init()
        presenter?.view = self
        router = .init()
        router?.view = self
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter = nil
        router = nil
    }
}
// MARK: - ...  Functions
extension LocationFromMapVC {
    func setup() {
        addressLbl.text = ""
        googleHelper = .init()
        googleHelper?.mapView = mapView
        googleHelper?.zoom = .inStreets
        googleHelper?.clearOnChangeMap = false
        googleHelper?.delegate = self
        locationHelper = .init()
        locationHelper?.onUpdateLocation = { [weak self] degree in
            self?.googleHelper?.updateCamera(lat: degree?.latitude ?? 0, lng: degree?.longitude ?? 0)
        }
        locationHelper?.onErrorLocation = { [weak self] in
            self?.router?.backToLocationRequestWithFail()
        }
        locationHelper?.currentLocation()
        
    }
}
extension LocationFromMapVC {
    @IBAction func save(_ sender: Any) {
        self.router?.backToLocationRequestWithSuccess()
    }
}
// MARK: - ...  View Contract
extension LocationFromMapVC: LocationFromMapViewContract {
}
extension LocationFromMapVC: GoogleMapHelperDelegate {
    func didChangeCameraLocation(lat: Double, lng: Double) {
        if locationHelper?.lat == nil {
            return
        }
        self.lat = lat
        self.lng = lng
        self.googleHelper?.setMarker(position: CLLocationCoordinate2D(latitude: lat, longitude: lng))
        self.googleHelper?.address(lat: lat, lng: lng, handler: { [weak self] (title, snippet, city) in
            self?.addressLbl.text = title
            self?.snippetAddress = snippet
            self?.cityLbl.text = city
        })
    }
    func didTapOnMap(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
        self.googleHelper?.setMarker(position: CLLocationCoordinate2D(latitude: lat, longitude: lng))
        self.googleHelper?.address(lat: lat, lng: lng, handler: { [weak self] (title, snippet,city) in
            self?.addressLbl.text = title
            self?.snippetAddress = snippet
            self?.cityLbl.text = city
        })
    }
}
