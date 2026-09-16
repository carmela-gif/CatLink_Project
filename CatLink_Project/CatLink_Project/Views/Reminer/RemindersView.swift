//
//  RemindersView.swift
//  CatLink_Project
//
//  Created by Mac-LAB on 9/8/26.
//

import SwiftUI
 
struct RemindersView: View {
    @EnvironmentObject var reminderController: ReminderController
    @State private var selectedTab: Tab = .upcoming
 
    enum Tab { case upcoming, completed }
 
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                Theme.background.ignoresSafeArea()
 
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Reminders")
                            .font(.largeTitle.bold())
 
                        HStack(spacing: 0) {
                            segmentButton("Upcoming", tab: .upcoming)
                            segmentButton("Completed", tab: .completed)
                        }
                        .padding(4)
                        .background(Color.white.opacity(0.6))
                        .clipShape(Capsule())
 
                        let list = selectedTab == .upcoming ? reminderController.upcoming : reminderController.completed
 
                        if list.isEmpty {
                            Text(selectedTab == .upcoming ? "No upcoming reminders." : "No completed reminders.")
                                .foregroundStyle(.secondary)
                                .frame(maxWidth: .infinity)
                                .padding(.top, 40)
                        } else {
                            VStack(spacing: 12) {
                                ForEach(list) { reminder in
                                    reminderRow(reminder)
                                }
                            }
                        }
                    }
                    .padding(24)
                    .padding(.bottom, 80)
                }
 
                NavigationLink {
                    AddReminderView()
                } label: {
                    Image(systemName: "plus")
                        .font(.title2.bold())
                        .foregroundStyle(.black)
                        .frame(width: 56, height: 56)
                        .background(Theme.accentYellow)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }
                .padding(24)
            }
            .navigationBarHidden(true)
        }
    }
 
    private func segmentButton(_ label: String, tab: Tab) -> some View {
        Button {
            selectedTab = tab
        } label: {
            Text(label)
                .font(.subheadline.weight(.semibold))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(selectedTab == tab ? Color.white : Color.clear)
                .clipShape(Capsule())
                .foregroundStyle(.black)
        }
    }
 
    /// Tap a reminder to mark it complete/incomplete — moves it between the two tabs.
    private func reminderRow(_ reminder: CareReminder) -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 2)
                .fill(reminder.tag.color)
                .frame(width: 4, height: 40)
 
            VStack(alignment: .leading, spacing: 4) {
                Text(reminder.title).font(.headline)
                Text(reminder.description).font(.subheadline).foregroundStyle(.secondary)
            }
 
            Spacer()
 
            Text(reminder.date)
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(Theme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .onTapGesture {
            reminderController.toggleComplete(reminder)
        }
    }
}
 
#Preview {
    RemindersView()
        .environmentObject(AuthController())
        .environmentObject(CatController())
        .environmentObject(ReminderController())
        .environmentObject(ReportController())
}
 
