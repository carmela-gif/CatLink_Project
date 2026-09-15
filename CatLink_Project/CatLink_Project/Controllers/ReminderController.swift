//
//  ReminderController.swift
//  CatLink_Project
//
//  Created by Mac-LAB on 9/7/26.
//

import Foundation
internal import Combine

@MainActor
final class ReminderController: ObservableObject {
    @Published var reminders: [CareReminder] = [
        CareReminder(title: "Feed Luna", description: "Wet food • 1/2 can", date: "Today, 6:00 PM"),
        CareReminder(title: "Vet Appointment", description: "Annual Checkup • Mochi", date: "Sep 15, 10:00 AM"),
        CareReminder(title: "Grooming", description: "Brush & nail trim • Luna", date: "Sep 20, 2:00 PM")
    ]
}
