//
//  MPermissionView.swift
//  
//
//  Created by Aydın Anlıaçık on 23.11.2022.
//

import SwiftUI

public struct MPermissionView: View {
    
    @ObservedObject public var manager: MPermissionManager
    
    public var uiConfiguration: MPUISetter?
    
    public init(
        manager: MPermissionManager,
        ui: MPUISetter?
    ) {
        self.manager = manager
        self.uiConfiguration = ui
    }
    
    public var body: some View {
        let serviceCount = manager.services.count
        
        ZStack {
            uiConfiguration?.backgroundColor
                .ignoresSafeArea()
            
            VStack {
                TitleText(text: "Permissions", color: .white)
                
                DescText(
                    text: uiConfiguration?.description.text ?? "Description",
                    color: uiConfiguration?.description.color ?? .white,
                    opacity: 0.5
                )
                
                List {
                    ForEach((0..<serviceCount), id: \.self) { index in
                        let service = manager.services[index]
                        
                        PermissionRow(service: service)
                    }
                }
                .environment(\.defaultMinListRowHeight, 60)
                .modifier(ScrollContentBackgroundModifier())
                
                
                if !manager.didGrandRequiredPermissions {
                    let requiredServices = manager.getRequiredServices()
                    
                    DescText(
                        text: "We still need \(requiredServices.count) permisson.",
                        color: .orange,
                        opacity: 1
                    ).padding(.bottom, 10)
                    
                    ForEach((0..<requiredServices.count), id: \.self) { index in
                        let service = requiredServices[index]
                        
                        DescText(
                            text: service.reason ?? "",
                            color: .orange,
                            opacity: 1
                        )
                        .padding(.bottom, 5)
                    }
                }

                Spacer()
                
                FWButton(
                    text: uiConfiguration?.doneBtn.text ?? "DONE",
                    txtColor: uiConfiguration?.doneBtn.color ?? .white
                ) {
                    manager.checkRequiredPermissions()
                }.padding(.top, 15)
            }
        }
    }
}

public struct MPermissionView_Previews: PreviewProvider {
    public static var previews: some View {
        let permissionManager = MPermissionManager(
            permissions: [
                MPTypeSetter(
                    type: .location,
                    isRequired: true,
                    description: "We need location permission.",
                    reason: "We are using location for sun and moon positions."
                ),
                MPTypeSetter(
                    type: .notification,
                    description: "We need notification permission."
                )
            ]
        )
        
        MPermissionView(
            manager: permissionManager,
            ui: nil
        )
    }
}
