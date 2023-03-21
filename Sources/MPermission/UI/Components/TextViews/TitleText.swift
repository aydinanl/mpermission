//
//  TitleText.swift
//  
//
//  Created by Aydın Anlıaçık on 24.11.2022.
//

import SwiftUI

struct TitleText: View {
    var text: String
    var color: Color = .black
    var size: CGFloat = 26
    var padding: CGFloat = 10
    
    var body: some View {
        Text(text)
            .foregroundColor(color)
            .font(.system(size: size))
            .padding(padding)
    }
}

struct TitleText_Previews: PreviewProvider {
    static var previews: some View {
        TitleText(
            text: "Test",
            color: .black
        )
    }
}
