//
//  DescText.swift
//
//
//  Created by Aydın Anlıaçık on 24.11.2022.
//

import SwiftUI

struct DescText: View {
    var text: String
    var aligment: TextAlignment = .center
    var color: Color = .black
    var opacity: Double = 1.0
    
    var body: some View {
        Text(text)
            .multilineTextAlignment(aligment)
            .foregroundColor(color)
            .font(.body)
            .opacity(opacity)
    }
}

struct DescText_Previews: PreviewProvider {
    static var previews: some View {
        DescText(
            text: "Test",
            color: .black
        )
    }
}
