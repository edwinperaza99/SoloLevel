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
    
    @MainActor
    func createUser() async throws {
        try await AuthService.shared.createUser(email: email, password: password)
    }
}
