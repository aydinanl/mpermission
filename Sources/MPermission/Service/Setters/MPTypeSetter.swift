//
//  MPTypeSetter.swift
//  
//
//  Created by Aydın Anlıaçık on 29.11.2022.
//

import Foundation

public struct MPTypeSetter {
    
    /// Type of permisson.
    public var type: MPermissionType
    
    /// Is type required for applicaiton.
    public var isRequired: Bool
    
    /// Description for permission for informing user.
    public var description: String
    
    /// Detailed reason for permission if it is required permission.
    public var reason: String?
    
    public init(
        type: MPermissionType,
        isRequired: Bool = false,
        description: String,
        reason: String? = nil
    ) {
        self.type = type
        self.isRequired = isRequired
        self.description = description
        self.reason = reason
    }
}
