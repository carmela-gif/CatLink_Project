//
//  EditProfileView.swift
//  CatLink_Project
//
//  Created by Mac-LAB on 9/8/26.
//

import SwiftUI
 
struct EditProfileView: View {
    @EnvironmentObject var authController: AuthController
    @Environment(\.dismiss) private var dismiss
 
    @State private var name = ""
    @State private var email = ""
    @State private var username = ""
 
    var body: some View {
        ZStack {
            Theme.background.ignoresSafeArea()
 
            VStack(spacing: 20) {
                ZStack(alignment: .bottomTrailing) {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 130, height: 130)
                        .foregroundStyle(.gray.opacity(0.6))
                        .clipShape(Circle())
 
                    Button {
                        // photo picker action
                    } label: {
                        // NOTE: original code used "Camera.fill" (capital C), which is not a
                        // valid SF Symbol name and would silently fail to render.
                        Image(systemName: "camera.fill")
                            .foregroundStyle(.black)
                            .padding(10)
                            .background(Theme.accentYellow)
                            .clipShape(Circle())
                    }
                }
                .frame(maxWidth: .infinity)
 
                VStack(alignment: .leading, spacing: 16) {
                    Text("Name")
                    TextField("Name", text: $name).roundedField()
 
                    Text("Email Address")
                    TextField("Email", text: $email).roundedField()
 
                    Text("Username")
                    TextField("Username", text: $username).roundedField()
                }
 
                Button(action: {
                    authController.user.fullName = name
                    authController.user.email = email
                    authController.user.username = username
                    dismiss()
                }) {
                    Text("Save Changes")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                }
                .buttonStyle(.borderedProminent)
                .tint(Theme.accentYellow)
                .foregroundStyle(.black)
                .clipShape(RoundedRectangle(cornerRadius: 14))
            }
            .padding(24)
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            name = authController.user.fullName
            email = authController.user.email
            username = authController.user.username
        }
    }
}
 
#Preview {
    EditProfileView()
        .environmentObject(AuthController())
        .environmentObject(CatController())
        .environmentObject(ReminderController())
        .environmentObject(ReportController())
}
