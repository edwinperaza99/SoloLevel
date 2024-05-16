//
//  LoginViewModel.swift
//  SoloLevel
//
//  Created by Edwin on 4/14/24.
//

import Foundation

enum LoginError: Error, LocalizedError {
    case invalidCredentials
    case unknownError

    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Invalid email or password."
        case .unknownError:
            return "An unknown error occurred. Please try again."
        }
    }
}

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    
    func login() async throws {
        do {
            isLoading = true
            try await AuthService.shared.login(email: email, password: password)
            isLoading = false
        } catch {
            isLoading = false
            throw LoginError.invalidCredentials
        }
        isLoading = false
    }
}
