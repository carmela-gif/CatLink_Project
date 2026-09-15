//
//  RegistrationView.swift
//  CatLink_Project
//
//  Created by Mac-LAB on 9/8/26.
//

import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject var authController: AuthController
    @Environment(\.dismiss) private var dismiss

    @State private var fullName = ""
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    @State private var acceptedTerms = false

    var body: some View {
        ZStack {
            Color(red: 255/255, green: 244/255, blue: 212/255)
                .ignoresSafeArea()

            Form {
                Section("Create Account") {
                    TextField("Full Name", text: $fullName)
                    TextField("Email Address", text: $email)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                    TextField("Username", text: $username)
                        .textInputAutocapitalization(.never)
                    SecureField("Password", text: $password)

                    Toggle("I agree to the Terms and Conditions", isOn: $acceptedTerms)
                }

                Section {
                    Button(action: {
                         authController.register(
                             fullName: fullName,
                             email: email,
                             username: username,
                             password: password
                         )
                         dismiss()
                    }) {
                        Text("Create Account")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color(red: 115/255, green: 86/255,  blue: 241/255))
                    .foregroundStyle(.black)
                    
                    .disabled(fullName.isEmpty || email.isEmpty || username.isEmpty ||
                              password.isEmpty || !acceptedTerms)
                }
                
            }
            .scrollContentBackground(.hidden)
        }
        .navigationTitle("Registration")
    }
}
#Preview {
    RegistrationView()
        .environmentObject(AuthController())
        .environmentObject(CatController())
        .environmentObject(ReminderController())
        .environmentObject(ReportController())
}
