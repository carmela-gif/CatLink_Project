//
//  EditProfileView.swift
//  CatLink_Project
//
//  Created by Mac-LAB on 9/8/26.
//

import SwiftUI
import PhotosUI
 
struct EditProfileView: View {
    @EnvironmentObject var authController: AuthController
    @Environment(\.dismiss) private var dismiss
 
    @State private var name = ""
    @State private var email = ""
    @State private var username = ""
 
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var selectedImageData: Data?
 
    var body: some View {
        ZStack {
            Theme.background.ignoresSafeArea()
 
            VStack(spacing: 20) {
                ZStack(alignment: .bottomTrailing) {
                    
                    Group {
                        if let selectedImageData, let uiImage = UIImage(data: selectedImageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                        } else {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.gray.opacity(0.6))
                        }
                    }
                    .frame(width: 130, height: 130)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Theme.accentYellow, lineWidth: 5)
                    )
 
                    PhotosPicker(selection: $selectedPhoto, matching: .images) {
                        Image(systemName: "camera.fill")
                            .foregroundStyle(.black)
                            .padding(10)
                            .background(Theme.accentYellow)
                            .clipShape(Circle())
                    }
                }
                .frame(maxWidth: .infinity)
                .onChange(of: selectedPhoto) {
                    Task {
                        if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
                            selectedImageData = data
                        }
                    }
                }
 
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
