//
//  MUISetter.swift
//  
//
//  Created by Aydın Anlıaçık on 28.11.2022.
//

import SwiftUI

public struct MPUISetter {
    
    /// Background color for PermissionView.
    var backgroundColor: Color
    
    /// Reason text for reqired permissions that not allowed.
    var reasonTxtColor: Color
    
    /// Description for requested permission service.
    var description: MPDescriptionSetItem
    
    /// Done button configuraitons.
    var doneBtn: MPDoneBtnSetItem
    
    public init(
        backgroundColor: Color,
        reasonTxtColor: Color,
        description: MPDescriptionSetItem,
        doneBtn: MPDoneBtnSetItem
    ) {
        self.backgroundColor = backgroundColor
        self.reasonTxtColor = reasonTxtColor
        self.description = description
        self.doneBtn = doneBtn
    }
}

public struct MPDescriptionSetItem {
    
    /// Text for description.
    var text: String
    
    /// Color for description.
    var color: Color
    
    public init(text: String, color: Color) {
        self.text = text
        self.color = color
    }
}

public struct MPDoneBtnSetItem {
    
    /// Text for done button.
    var text: String
    
    /// Color for done button.
    var color: Color
    
    public init(text: String, color: Color) {
        self.text = text
        self.color = color
    }
}
