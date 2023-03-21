//
//  MPCalendarService.swift
//  
//
//  Created by Aydın Anlıaçık on 1.12.2022.
//

import Foundation
import EventKit

final class MPCalendarService: MPermissionService {
    var completionHandler: (() -> Void)?
    
    var type: MPermissionType
    
    var status: MPermissionStatus = .notDetermined
    
    var isRequired: Bool
    
    var desc: String
    
    var reason: String?
    
    var eventStore = EKEventStore()
    
    init(setter: MPTypeSetter) {
        self.type = setter.type
        self.isRequired = setter.isRequired
        self.desc = setter.description
        self.reason = setter.reason
        
        let _ = hasPermission()
    }
    
    func hasPermission() -> Bool {
        let status = EKEventStore.authorizationStatus(for: .event)
        
        if status == .authorized {
            self.status = .authorized
        }
        
        return status == .authorized
    }
    
    func requestPermission(completion: @escaping () -> Void) {
        completionHandler = completion
        
        eventStore
            .requestAccess(
                to: .event
            ) { (granted: Bool, error: Error?) -> Void in
                let _ = self.hasPermission()
                self.completionHandler?()
            }
    }
}
