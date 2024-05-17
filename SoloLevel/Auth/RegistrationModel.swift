//
//  RegistrationModel.swift
//  SoloLevel
//
//  Created by Edwin on 4/13/24.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    
    @MainActor
    func createUser() async throws {
        do {
            isLoading = true
            try await AuthService.shared.createUser(email: email, password: password)
        } catch {
            isLoading = false
            throw error
        }
        isLoading = false
    }
}
