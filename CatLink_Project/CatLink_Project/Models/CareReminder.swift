//
//  CareReminder.swift
//  CatLink_Project
//
//  Created by Mac-LAB on 9/8/26.
//

import SwiftUI

enum ReminderTag: String {
    case feeding, medication, vet, grooming
 
    var color: Color {
        switch self {
        case .feeding: return Theme.accentYellow
        case .medication: return .blue
        case .vet: return Theme.accentPurple
        case .grooming: return .gray
        }
    }
}
 
struct CareReminder: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var date: String
    var tag: ReminderTag = .feeding
    var isCompleted: Bool = false
}
 
