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
    
    @MainActor
    func login(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            print("User has log in")
        } catch {
            print("Error: \(error.localizedDescription)")
            throw error
        }
    }
    
    @MainActor
    func createUser(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            print("Created new user: \(result.user.uid)")
//            create database collection for user
            try await DatabaseManager.shared.createNewUser()
            print("New user has been added to database")
        } catch {
            print("Error: \(error.localizedDescription)")
            throw error
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        self.userSession = nil
    }
    
    func sendPasswordReset(email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func changeEmail(newEmail: String, completion: @escaping (Result<Void, Error>) -> Void) {
        userSession?.updateEmail(to: newEmail) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
