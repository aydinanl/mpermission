//
//  File.swift
//  
//
//  Created by Aydın Anlıaçık on 30.11.2022.
//

import Foundation
import AVFoundation

final class MPCamereService: MPermissionService {
    
    var completionHandler: (() -> Void)?
    
    var type: MPermissionType
    
    var status: MPermissionStatus = .notDetermined
    
    var isRequired: Bool
    
    var desc: String
    
    var reason: String?
    
    init(setter: MPTypeSetter) {
        self.type = setter.type
        self.isRequired = setter.isRequired
        self.desc = setter.description
        self.reason = setter.reason
        
        let _ = hasPermission()
    }
    
    func hasPermission() -> Bool {
        let status = AVCaptureDevice.authorizationStatus(for: .video)

        if status == .authorized {
            self.status = .authorized
        }
        
        return status == .authorized
    }
    
    func requestPermission(completion: @escaping () -> Void) {
        completionHandler = completion
        
        AVCaptureDevice.requestAccess(for: .video)
        { (granted: Bool) -> Void in
            let _ = self.hasPermission()
            self.completionHandler?()
        }
    }
}
