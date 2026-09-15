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
        ZStack {
            Color(red: 255/255, green: 244/255, blue: 212/255)
                .ignoresSafeArea()

            NavigationStack {
                VStack(spacing: 20) {
                    Spacer()
                    
                    Image("Cat:|")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color(red: 255/255, green: 199/255, blue: 44/255), lineWidth: 4)
                        )

                    Text("CatLink")
                        .font(.largeTitle.bold())

                    Text("Local Life and Animal Management")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    VStack(spacing: 14) {
                        TextField("Username or Email", text: $username)
                            .textFieldStyle(.roundedBorder)
                            .textInputAutocapitalization(.never)

                        SecureField("Password", text: $password)
                            .textFieldStyle(.roundedBorder)

                        Button("Forgot Password?") { }
                            .font(.footnote)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .tint(Color(red: 115/255, green: 86/255,  blue: 241/255))
                        
                        
                        Spacer()

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
                        .tint(Color(red: 255/255, green: 199/255, blue: 44/255))
                        .foregroundStyle(.black)
                        
                    }

                    if showError {
                        Text("Invalid username/email or password.")
                            .foregroundStyle(.red)
                            .font(.footnote)
                    }
                    
                    HStack{
                        
                        Text("Don't have an account?")
                        
                        NavigationLink("Register") {
                            RegistrationView()
                        }
                        .tint(Color(red: 115/255, green: 86/255,  blue: 241/255))

                    }
                    Spacer()
                }
                .padding(24)
                .background(Color(red: 255/255, green: 244/255, blue: 212/255))
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
