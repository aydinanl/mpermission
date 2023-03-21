//
//  MPermissionFactory.swift
//  
//
//  Created by Aydın Anlıaçık on 24.11.2022.
//

import Foundation
import SwiftUI

public protocol MPermissionService {
    
    // MARK: Events
    var completionHandler: (() -> Void)? { get }
        
    // MARK: Variables
    
    /// Type of permission in Service
    var type: MPermissionType { set get }
    
    /// Status of permission.
    var status: MPermissionStatus { set get }
    
    /// Is required permission for application.
    var isRequired: Bool { get set }
    
    /// Description text for needed permission
    var desc: String { set get }
    
    /// Detailed reason for needed permission
    var reason: String? { set get }
    
    init(setter: MPTypeSetter)
    
    // MARK: Actions
    
    /// Service has permission.
    func hasPermission() -> Bool
    
    /// Request permission for service.
    func requestPermission(completion: @escaping () -> Void)
}

final class MPServiceFactory {
    
    /// Create permission service instance with setter.
    /// - Parameter setter: MPTypeSetter
    /// - Returns: MPermissionService
    public func createPermissionService(
        for setter: MPTypeSetter
    ) -> MPermissionService? {
        return setter.type.getService(from: setter)
    }
}
