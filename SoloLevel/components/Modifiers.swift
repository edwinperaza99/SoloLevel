//
//  Text-Modifier.swift
//  SoloLevel
//
//  Created by csuftitan on 4/13/24.
//

import Foundation
import SwiftUI

struct CustomTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .multilineTextAlignment(.center)
            .textCase(.uppercase)
    }
}

struct CustomButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 150, minHeight: 50)
            .background(
                RoundedRectangle(cornerRadius: 3) // Square corners
                    .strokeBorder(
                            LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.3), Color.white]), startPoint: .top, endPoint: .bottom),
                            lineWidth: 2
                    )
                    .background(Color.clear) // Ensure the inside of the border is transparent
                    .shadow(color: .white, radius: 10, x: 0, y: 0) // Glowing effect
            )
            .foregroundColor(.white)
    }
}

extension View {
    func customTextStyle() -> some View {
        self.modifier(CustomTextModifier())
    }
    func customButtonStyle() -> some View {
        self.modifier(CustomButtonModifier())
    }
}
