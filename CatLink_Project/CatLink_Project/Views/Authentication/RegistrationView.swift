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
            Theme.background.ignoresSafeArea()
 
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    Text("Create Account")
                        .font(.largeTitle.bold())
                        .padding(.top, 12)
 
                    Group {
                        Text("Full Name").font(.subheadline).fontWeight(.semibold)
                        TextField("e.g. Anne Aureada", text: $fullName)
                            .roundedField()
                    }
 
                    Group {
                        Text("Email Address").font(.subheadline).fontWeight(.semibold)
                        TextField("e.g. annie@email.com", text: $email)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                            .roundedField()
                    }
 
                    Group {
                        Text("Username").font(.subheadline).fontWeight(.semibold)
                        TextField("e.g. annie_aureada", text: $username)
                            .textInputAutocapitalization(.never)
                            .roundedField()
                    }
 
                    Group {
                        Text("Password").font(.subheadline).fontWeight(.semibold)
                        SecureField("Create robust password", text: $password)
                            .roundedField()
                    }
 
                    Button {
                        acceptedTerms.toggle()
                    } label: {
                        HStack(spacing: 10) {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(acceptedTerms ? Theme.accentYellow : Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.gray.opacity(0.4))
                                )
                                .frame(width: 24, height: 24)
                                .overlay {
                                    if acceptedTerms {
                                        Image(systemName: "checkmark")
                                            .font(.caption.bold())
                                            .foregroundStyle(.black)
                                    }
                                }
                            HStack{
                                Text("I agree to the")
                                    .font(.footnote)
                                    .foregroundStyle(.secondary)
                                Link("Terms of Service & Privacy Policy", destination: URL(string: "https://google.com")!)
                                    .font(.footnote)
                                    .tint(Theme.accentPurple)
                            }
                        }
                    }
                    .buttonStyle(.plain)
 
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
                            .padding(.vertical, 14)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Theme.accentYellow)
                    .foregroundStyle(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .disabled(fullName.isEmpty || email.isEmpty || username.isEmpty ||
                              password.isEmpty || !acceptedTerms)
 
                    HStack {
                        Spacer()
                        Text("Already have an account?")
                        Button("Login") { dismiss() }
                            .tint(Theme.accentPurple)
                        Spacer()
                    }
                    .font(.footnote)
                }
                .padding(24)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
 
#Preview {
    RegistrationView()
        .environmentObject(AuthController())
        .environmentObject(CatController())
        .environmentObject(ReminderController())
        .environmentObject(ReportController())
}
