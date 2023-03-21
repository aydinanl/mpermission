//
//  ScrollContentBackgroundModifier.swift
//  
//
//  Created by Aydın Anlıaçık on 25.11.2022.
//

import SwiftUI

struct ScrollContentBackgroundModifier: ViewModifier {

    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .scrollContentBackground(.hidden)
        } else {
            content
        }
    }
}
