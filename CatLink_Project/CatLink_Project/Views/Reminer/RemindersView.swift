//
//  RemindersView.swift
//  CatLink_Project
//
//  Created by Mac-LAB on 9/8/26.
//

import SwiftUI

struct RemindersView: View {
    @EnvironmentObject var reminderController: ReminderController

    var body: some View {
        ZStack {
            Color(red: 255/255, green: 244/255, blue: 212/255)
                .ignoresSafeArea()

            List {
                Section("Upcoming") {
                    ForEach(reminderController.reminders) { reminder in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(reminder.title).font(.headline)
                            Text(reminder.description).foregroundStyle(.secondary)
                            Text(reminder.date).font(.caption)
                        }
                        .padding(.vertical, 4)
                    }
                }

                Section("Completed") {
                    Text("No completed reminders.")
                        .foregroundStyle(.secondary)
                }
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Reminders")
        }
    }
}
