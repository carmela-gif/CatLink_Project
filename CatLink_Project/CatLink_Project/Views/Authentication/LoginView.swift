//
//  LoginView.swift
//  CatLink_Project
//
//  Created by Mac-LAB on 9/8/26.
//

import SwiftUI
 
struct LoginView: View {
    @EnvironmentObject var authController: AuthController
    @State private var username = ""
    @State private var password = ""
    @State private var showError = false
 
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.background.ignoresSafeArea()
 
                VStack(spacing: 20) {
                    Spacer()
 
                    Image(systemName: "cat.fill")
                        .font(.system(size: 60))
                        .foregroundStyle(.white)
                        .frame(width: 150, height: 150)
                        .background(Theme.accentYellow.opacity(0.7))
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Theme.accentYellow, lineWidth: 4)
                        )
 
                    Text("CatLink")
                        .font(.largeTitle.bold())
 
                    Text("Local Life and Animal Management")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
 
                    Spacer()
 
                    VStack(spacing: 14) {
                        TextField("Username or Email", text: $username)
                            .textInputAutocapitalization(.never)
                            .roundedField()
 
                        SecureField("Password", text: $password)
                            .roundedField()
 
                        Button("Forgot Password?") { }
                            .font(.footnote)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .tint(Theme.accentPurple)
                    }
 
                    if showError {
                        Text("Invalid username/email or password.")
                            .foregroundStyle(.red)
                            .font(.footnote)
                    }
 
                    Button(action: {
                        authController.login(username: username, password: password)
                        showError = !authController.isLoggedIn
                    }) {
                        Text("Login")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Theme.accentYellow)
                    .foregroundStyle(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
 
                    HStack {
                        Text("Don't have an account?")
                        NavigationLink("Register") {
                            RegistrationView()
                        }
                        .tint(Theme.accentPurple)
                    }
                    .font(.footnote)
 
                    Spacer()
                }
                .padding(24)
            }
        }
    }
}
 
#Preview {
    LoginView()
        .environmentObject(AuthController())
        .environmentObject(CatController())
        .environmentObject(ReminderController())
        .environmentObject(ReportController())
}
