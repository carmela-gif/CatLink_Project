//
//  CatLink_ProjectApp.swift
//  CatLink_Project
//
//  Created by Mac-LAB on 9/7/26.
//

import SwiftUI

@main
struct CatLinkApp: App {
    @StateObject private var authController = AuthController()
    @StateObject private var catController = CatController()
    @StateObject private var reminderController = ReminderController()
    @StateObject private var reportController = ReportController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authController)
                .environmentObject(catController)
                .environmentObject(reminderController)
                .environmentObject(reportController)
        }
    }
}
