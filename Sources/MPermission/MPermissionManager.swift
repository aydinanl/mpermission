//
//  MPermissionManager.swift
//
//
//  Created by Aydın Anlıaçık on 24.11.2022.
//

import SwiftUI

public class MPermissionManager: ObservableObject {
    
    /// Permissions configuration setters.
    var setters: [MPTypeSetter] = []
    
    /// Service objects for permission with spesific Type.
    var services: [MPermissionService] = []
    
    /// MPermissionView listens this flag for showing required permission info section.
    @Published var didGrandRequiredPermissions: Bool = true
    
    /// App module listens this flag for checking app needs any permission before showing it's view.
    @Published public var hasAnyPermissionRequest: Bool?
    
    public init(
        permissions: [MPTypeSetter]
    ) {
        setters = permissions
        
        createServices()
    }
    
    /// Create service instances from setters for every permission type.
    private func createServices() {
        let factory = MPServiceFactory()
        
        for setter in setters {
            if let service = factory.createPermissionService(
                for: setter
            ) {
                services.append(service)
            }
        }
        
        hasAnyPermissionRequest = hasAnyPermissionRequests()
    }
    
    /// MPermissionView's done action triggers here due to checking user give all required permission to app.
    public func checkRequiredPermissions() {
        var grand = true
        
        for service in services {
            if
                service.isRequired,
                service.status != .authorized
            {
                grand = false
                break
            }
        }
        
        didGrandRequiredPermissions = grand
        hasAnyPermissionRequest = !grand
    }
    
    @discardableResult
    public func hasAnyPermissionRequests() -> Bool {
        // Check for required permissions with not authorized.
        
        var grand = true
        
        for service in services {
            if
                service.isRequired,
                service.status != .authorized
            {
                grand = false
                break
            }
        }
        
        return !grand
    }
    
    /// Find permissions services that are required and not have permission.
    /// - Returns: [MPermissionService]
    public func getRequiredServices() -> [MPermissionService] {
        let services = services.filter { $0.isRequired && !$0.hasPermission() }
        
        return services
    }
    
    /// Prepare a MPermissionView for displaying Permission management UI on App side.
    /// - Parameter ui: MPUISetter - Spesific Struct for handling UI assignments.
    /// - Returns: MPermissionView
    public func present(with ui: MPUISetter) -> some View {
        return MPermissionView(manager: self, ui: ui)
    }
}
