//
//  PermissionRow.swift
//  
//
//  Created by Aydın Anlıaçık on 25.11.2022.
//

import SwiftUI

struct PermissionRow: View {
    
    var service: MPermissionService
    
    @State var didGrandPermission: Bool = false
    
    public init(service: MPermissionService) {
        self.service = service
        self.didGrandPermission = service.status == .authorized
    }
    
    var body: some View {
        let width = UIScreen.main.bounds.width - 54
        
        HStack(alignment: .center, spacing: 8) {
            VStack(alignment: .leading, spacing: 0) {
                TitleText(
                    text: "\(service.type)".capitalized,
                    color: .black,
                    size: 20,
                    padding: 0
                )
                .frame(width: width - 90, alignment: .leading)
                
                DescText(
                    text: service.desc,
                    color: .black,
                    opacity: 0.5
                )
                .frame(width: width - 90, alignment: .leading)
                .minimumScaleFactor(0.5)
                .lineLimit(1)
            }
            .frame(width: width - 90)
            
            let btnColor: Color = (
                didGrandPermission || service.hasPermission()
                ? Color.green
                : Color.blue
            )

            Button {
                service.requestPermission {
                    didGrandPermission = service.hasPermission()
                }
            } label: {
                let state: String = (
                    didGrandPermission || service.hasPermission()
                    ? "ALLOWED"
                    : "ALLOW"
                )
                
                Text(state)
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
            }
            .padding(8)
            .cornerRadius(8)
            .frame(width: 80)
            .background(btnColor)
            .cornerRadius(8)
        }
        .fixedSize(horizontal: true, vertical: false)
        .frame(minWidth: width, maxWidth: width, minHeight: 60)
    }
}

struct PermissionRow_Previews: PreviewProvider {
    static var previews: some View {
        let service = MPermissionType
            .notification
            .getService(
                from: MPTypeSetter(
                    type: .location,
                    description: "We need location permission.",
                    reason: "We are using location for sun and moon positions."
                )
            )
        
        PermissionRow(service: service!)
    }
}
