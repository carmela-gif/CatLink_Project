//
//  ContentView.swift
//  CatLink_Project
//
//  Created by Mac-LAB on 9/8/26.
//

import SwiftUI
 
struct ContentView: View {
    @EnvironmentObject var authController: AuthController
 
    var body: some View {
        ZStack {
            Theme.background.ignoresSafeArea()
 
            if authController.isLoggedIn {
                MainTabView()
            } else {
                LoginView()
            }
        }
    }
}
 
#Preview {
    ContentView()
        .environmentObject(AuthController())
        .environmentObject(CatController())
        .environmentObject(ReminderController())
        .environmentObject(ReportController())
}
 
