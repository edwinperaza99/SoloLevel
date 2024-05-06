//
//  DatabaseManager.swift
//  SoloLevel
//
//  Created by Edwin on 5/6/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class DatabaseManager {
    static let shared = DatabaseManager()
    private init() {}
    
    func createNewUser() async throws{
        guard let userId = AuthService.shared.userSession?.uid,
               let email = AuthService.shared.userSession?.email else {
             throw NSError(domain: "AuthServiceError", code: -1, userInfo: [NSLocalizedDescriptionKey: "User session not available."])
         }
        // Derive initial name from email (everything before the "@" symbol)
        let name = email.components(separatedBy: "@").first ?? "Unknown"
        
        // Define initial values for other fields
        let initialStatsValue = 10
        let initialLevel = 1
        
        let newUser = User(userId: userId,
                           email: email,
                           dateCreated: Date(),
                           level: initialLevel,
                           name: name,
                           job: "Unknown",
                           title: "Unknown",
                           hp: initialStatsValue,
                           mp: initialStatsValue,
                           strength: initialStatsValue,
                           health: initialStatsValue,
                           agility: initialStatsValue,
                           intelligence: initialStatsValue,
                           sense: initialStatsValue,
                           mind: initialStatsValue,
                           ability: "Unknown")
        
        try await Firestore.firestore().collection("users").document(userId).setData(from: newUser)
    }
    func getUserProfile() async throws {
        guard let userId = AuthService.shared.userSession?.uid else {
             throw NSError(domain: "AuthServiceError", code: -1, userInfo: [NSLocalizedDescriptionKey: "User session not available."])
         }
        let snapshot = try await Firestore.firestore().collection("users").document(userId).getDocument()
    }
}
