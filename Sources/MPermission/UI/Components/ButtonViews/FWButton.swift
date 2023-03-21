//
//  FWButton.swift
//  
//
//  Created by Aydın Anlıaçık on 25.11.2022.
//

import SwiftUI

struct FWButton: View {
    
    var text: String
    var txtColor: Color = .black
    var bgColor: Color = .orange
    
    var didClick: (() -> Void)?
    
    var body: some View {
        Button {
            didClick?()
        } label: {
            Text(text)
                .padding(15)
                .frame(maxWidth: .infinity)
                .foregroundColor(txtColor)
        }
        .background(bgColor)
        .cornerRadius(10)
        .padding(10)
    }
}

struct FWButton_Previews: PreviewProvider {
    static var previews: some View {
        FWButton(
            text: "Done",
            txtColor: .white
        )
    }
}
