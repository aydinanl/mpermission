//
//  MPNotificationService.swift
//  
//
//  Created by Aydın Anlıaçık on 24.11.2022.
//

import Foundation
import UserNotifications

final class MPNotificationService: MPermissionService {
    
    var completionHandler: (() -> Void)?
    
    var type: MPermissionType = .notification
    
    var status: MPermissionStatus = .notDetermined
    
    var isRequired: Bool
    
    var desc: String
    
    var reason: String?
    
    init(setter: MPTypeSetter) {
        self.type = setter.type
        self.reason = setter.reason
        self.desc = setter.description
        self.isRequired = setter.isRequired
    }

    func hasPermission() -> Bool {
        let center = UNUserNotificationCenter.current()
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                self.status = .authorized
            }
        }
        
        return self.status == .authorized
    }
    
    func requestPermission(completion: @escaping () -> Void) {
        completionHandler = completion
        
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if error != nil {
                self.status = .notDetermined
            }
            
            self.completionHandler?()
        }
    }
}
