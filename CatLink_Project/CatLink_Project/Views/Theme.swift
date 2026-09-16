//
//  Theme.swift
//  CatLink_Project
//
//  Shared colors and styles so every screen matches the Figma design.
//

import SwiftUI

enum Theme {
    static let background = Color(red: 255/255, green: 244/255, blue: 212/255)
    static let accentYellow = Color(red: 255/255, green: 199/255, blue: 44/255)
    static let accentPurple = Color(red: 115/255, green: 86/255, blue: 241/255)
    static let cardBackground = Color.white.opacity(0.9)
}

/// White rounded text-field background used throughout the Figma (Login, Registration,
/// Add Cat, Add Report, Add Reminder, Edit Profile) instead of the default Form styling.
struct RoundedField: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(12)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

extension View {
    func roundedField() -> some View {
        modifier(RoundedField())
    }
}
