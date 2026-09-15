//
//  MainTabView.swift
//  CatLink_Project
//
//  Created by Mac-LAB on 9/8/26.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem { Label("Dashboard", systemImage: "house.fill") }

            MyCatsView()
                .tabItem { Label("My Cats", systemImage: "cat.fill") }

            RemindersView()
                .tabItem { Label("Reminders", systemImage: "bell.fill") }

            ProfileView()
                .tabItem { Label("Profile", systemImage: "person.fill") }
        }
    }
}
#Preview {
    MainTabView()
        .environmentObject(AuthController())
        .environmentObject(CatController())
        .environmentObject(ReminderController())
        .environmentObject(ReportController())
}
