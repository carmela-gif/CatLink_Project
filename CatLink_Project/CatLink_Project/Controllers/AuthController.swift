//
//  AuthControllers.swift
//  CatLink_Project
//
//  Created by Mac-LAB on 9/7/26.
//

import Foundation
internal import Combine
 
@MainActor
final class AuthController: ObservableObject {
    @Published var isLoggedIn = false
 
    @Published var user = User(
        fullName: "Annie Aureada",
        email: "email",
        username: "annie_aureada",
        password: "123"
    )
 
    func login(username: String, password: String) {
        if (username == user.email || username == user.username) &&
            password == user.password {
            isLoggedIn = true
        }
    }
 
    func register(fullName: String, email: String, username: String, password: String) {
        user = User(
            fullName: fullName,
            email: email,
            username: username,
            password: password
        )
        isLoggedIn = false
    }
 
    func logout() {
        isLoggedIn = false
    }
}
 
