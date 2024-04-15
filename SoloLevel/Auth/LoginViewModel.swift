//
//  LoginViewModel.swift
//  SoloLevel
//
//  Created by csuftitan on 4/14/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func login() async throws {
        try await AuthService.shared.login(email: email, password: password)
    }
}
