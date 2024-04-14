//
//  AuthService.swift
//  SoloLevel
//
//  Created by Edwin on 4/13/24.
//

import FirebaseAuth

class AuthService {
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService()
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    func createUser(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            print("Created new user: \(result.user.uid)")
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
