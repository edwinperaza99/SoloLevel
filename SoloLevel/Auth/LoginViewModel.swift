//
//  LoginViewModel.swift
//  SoloLevel
//
//  Created by Edwin on 4/14/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    func login() async {
        do {
            isLoading = true
            try await AuthService.shared.login(email: email, password: password)
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
