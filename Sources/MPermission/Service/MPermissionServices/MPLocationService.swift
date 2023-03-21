//
//  File.swift
//  
//
//  Created by Aydın Anlıaçık on 24.11.2022.
//

import Foundation
import CoreLocation

final class MPLocationService: NSObject, MPermissionService {
    
    var completionHandler: (() -> Void)?
    
    var type: MPermissionType = .location
    
    var status: MPermissionStatus = .notDetermined
    
    var isRequired: Bool = false
    
    var desc: String = "We need location permission."
    
    var reason: String?
    
    // MARK: Service Spesific
    
    var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        
        self.setStatusByLocation()
    }
    
    convenience init(setter: MPTypeSetter) {
        self.init()
        
        self.desc = setter.description
        self.reason = setter.reason
        self.isRequired = setter.isRequired
    }
    
    deinit {
        locationManager.delegate = nil
    }
    
    func setStatusByLocation() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            status = .notDetermined
        case .restricted:
            status = .restricted
        case .denied:
            status = .denied
        case .authorizedAlways:
            status = .authorized
        case .authorizedWhenInUse:
            status = .authorized
        @unknown default:
            status = .notDetermined
        }
    }
    
    func hasPermission() -> Bool {
        if status == .denied
            || status == .restricted
            || status == .notDetermined
        {
            return false
        }
        
        return true
    }
    
    func requestPermission(completion: @escaping () -> Void) {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        completionHandler = completion
    }

}

extension MPLocationService: CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus
    ) {
        setStatusByLocation()
        completionHandler?()
    }
}
