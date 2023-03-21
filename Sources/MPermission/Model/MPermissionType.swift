//
//  MPermissionType.swift
//  
//
//  Created by Aydın Anlıaçık on 24.11.2022.
//

import Foundation

/// Permission Type's that Package supported.
public enum MPermissionType {
    case location
    case notification
    case camera
    case calendar
    
    func getService(
        from setter: MPTypeSetter
    ) -> MPermissionService? {
        switch self {
        case .location:
            return MPLocationService(setter: setter)
        case .notification:
            return MPNotificationService(setter: setter)
        case .camera:
            return MPCamereService(setter: setter)
        case .calendar:
            return MPCalendarService(setter: setter)
        }
    }
}
