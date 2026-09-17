//
//  Theme.swift
//  CatLink_Project
//
//  Created by Mac-LAB on 9/15/26.
//

import SwiftUI

enum Theme {
    static let background = Color(red: 255/255, green: 244/255, blue: 212/255)
    static let accentYellow = Color(red: 255/255, green: 199/255, blue: 44/255)
    static let accentPurple = Color(red: 115/255, green: 86/255, blue: 241/255)
    static let cardBackground = Color.white.opacity(0.9)
}

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
