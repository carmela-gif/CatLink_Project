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
        CareReminder(title: "Feed Luna", description: "Wet food • 1/2 can",
                     date: "Today, 6:00 PM", tag: .feeding),
        CareReminder(title: "Medication", description: "De-worming pill",
                     date: "Tomorrow, 9:00 AM", tag: .medication),
        CareReminder(title: "Vet Appointment", description: "Annual Checkup • Mochi",
                     date: "Sep 15, 10:00 AM", tag: .vet),
        CareReminder(title: "Grooming", description: "Brush & nail trim • Luna",
                     date: "Sep 20, 2:00 PM", tag: .grooming)
    ]
 
    var upcoming: [CareReminder] { reminders.filter { !$0.isCompleted } }
    var completed: [CareReminder] { reminders.filter { $0.isCompleted } }
 
    func addReminder(_ reminder: CareReminder) {
        reminders.append(reminder)
    }
 
    func toggleComplete(_ reminder: CareReminder) {
        if let index = reminders.firstIndex(where: { $0.id == reminder.id }) {
            reminders[index].isCompleted.toggle()
        }
    }
}
