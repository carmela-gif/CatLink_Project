//
//  ProfileView.swift
//  CatLink_Project
//
//  Created by Mac-LAB on 9/8/26.
//

import SwiftUI
 
struct ProfileView: View {
    @EnvironmentObject var authController: AuthController
    @EnvironmentObject var catController: CatController
    @EnvironmentObject var reminderController: ReminderController
 
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.background.ignoresSafeArea()
 
                ScrollView {
                    VStack(spacing: 20) {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 80))
                            .foregroundStyle(.gray.opacity(0.6))
 
                        VStack(spacing: 4) {
                            Text(authController.user.fullName)
                                .font(.title2.bold())
                            Text(authController.user.email)
                                .foregroundStyle(.secondary)
                        }
 
                        HStack {
                            statColumn(value: "\(catController.cats.count)", label: "Cats Managed")
                            Divider().frame(height: 40)
                            statColumn(value: "\(reminderController.reminders.count)", label: "Reminders Set")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Theme.cardBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
 
                        NavigationLink {
                            EditProfileView()
                        } label: {
                            Text("Edit Profile")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(Theme.accentYellow)
                        .foregroundStyle(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
 
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Settings & Preferences")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
 
                            settingsRow(icon: "cat.fill", title: "My Cats") {
                                MyCatsView()
                            }
                            settingsRow(icon: "bell.fill", title: "Notifications") {
                                EmptyView()
                            }
                            settingsRow(icon: "questionmark.circle.fill", title: "Help & Support") {
                                EmptyView()
                            }
 
                            Button(role: .destructive) {
                                authController.logout()
                            } label: {
                                Text("Logout")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                            }
                            .background(Color.red.opacity(0.12))
                            .foregroundStyle(.red)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                        }
                    }
                    .padding(24)
                }
            }
            .navigationBarHidden(true)
        }
    }
 
    private func statColumn(value: String, label: String) -> some View {
        VStack(spacing: 4) {
            Text(value).font(.title2.bold())
            Text(label).font(.caption).foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
 
    @ViewBuilder
    private func settingsRow<Destination: View>(
        icon: String, title: String, @ViewBuilder destination: () -> Destination
    ) -> some View {
        NavigationLink {
            destination()
        } label: {
            HStack {
                Image(systemName: icon)
                    .frame(width: 32, height: 32)
                    .background(Theme.accentYellow.opacity(0.2))
                    .clipShape(Circle())
                Text(title)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.secondary)
            }
            .padding()
            .background(Theme.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .foregroundStyle(.black)
        }
    }
}
 
#Preview {
    ProfileView()
        .environmentObject(AuthController())
        .environmentObject(CatController())
        .environmentObject(ReminderController())
        .environmentObject(ReportController())
}
 
