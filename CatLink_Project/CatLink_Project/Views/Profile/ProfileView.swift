//
//  ProfileView.swift
//  CatLink_Project
//
//  Created by Mac-LAB on 9/8/26.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authController: AuthController

    var body: some View {
        ZStack {
            Color(red: 255/255, green: 244/255, blue: 212/255)
                .ignoresSafeArea()

            NavigationStack {
                List {
                    Section {
                        VStack(spacing: 8) {
                            Image(systemName: "person.crop.circle.fill")
                                .font(.system(size: 70))
                            Text(authController.user.fullName)
                                .font(.title2.bold())
                            Text(authController.user.email)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical)
                    }

                    Section {
                        NavigationLink("Edit Profile") {
                            EditProfileView()
                        }
                        NavigationLink("My Cats") {
                            MyCatsView()
                        }
                        Text("Notifications")
                        Text("Help & Support")
                    }

                    Section {
                        Button("Logout", role: .destructive) {
                            authController.logout()
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .navigationTitle("Profile")
            }
        }
    }
}
