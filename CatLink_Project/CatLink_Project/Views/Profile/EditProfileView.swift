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
            Color(red: 255/255, green: 244/255, blue: 212/255)
                .ignoresSafeArea()

            Form {
                TextField("Name", text: $name)
                TextField("Email", text: $email)
                TextField("Username", text: $username)

                Button("Save Changes") {
                    authController.user.fullName = name
                    authController.user.email = email
                    authController.user.username = username
                    dismiss()
                }
                .tint(Color(red: 255/255, green: 199/255, blue: 44/255))
            }
            .scrollContentBackground(.hidden)
        }
        .navigationTitle("Edit Profile")
        .onAppear {
            name = authController.user.fullName
            email = authController.user.email
            username = authController.user.username
        }
    }
}
