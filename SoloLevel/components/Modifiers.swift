//
//  Text-Modifier.swift
//  SoloLevel
//
//  Created by Edwin on 4/13/24.
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

struct CustomTextModifierSM: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .multilineTextAlignment(.leading)
            .textCase(.uppercase)
    }
}

struct AlignLeftModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
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

struct CustomInputFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(Color(.systemGray3), lineWidth: 1)
                    .padding(.horizontal, -12)
            )
            .padding(.horizontal, 24)
    }
}

extension View {
    func customTextStyle() -> some View {
        self.modifier(CustomTextModifier())
    }
    func customTextStyleSM() -> some View {
        self.modifier(CustomTextModifierSM())
    }
    func AlignLeft() -> some View {
        self.modifier(AlignLeftModifier())
    }
    func customButtonStyle() -> some View {
        self.modifier(CustomButtonModifier())
    }
    func customInputFieldStyle() -> some View {
        self.modifier(CustomInputFieldModifier())
    }
}
