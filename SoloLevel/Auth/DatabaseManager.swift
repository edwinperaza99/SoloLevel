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
    
    func getUserProfile() async throws -> User {
        guard let userId = AuthService.shared.userSession?.uid else {
             throw NSError(domain: "AuthServiceError", code: -1, userInfo: [NSLocalizedDescriptionKey: "User session not available."])
         }
        let snapshot = try await Firestore.firestore().collection("users").document(userId).getDocument()
        guard let data = snapshot.data() else {
            throw URLError(.badServerResponse)
        }
        let user = try snapshot.data(as: User.self)
        return user
    }
    
    func levelUpUser() async throws {
        guard let userId = AuthService.shared.userSession?.uid else {
            throw NSError(domain: "AuthServiceError", code: -1, userInfo: [NSLocalizedDescriptionKey: "User session not available."])
        }

        let snapshot = try await Firestore.firestore().collection("users").document(userId).getDocument()

        guard let data = snapshot.data() else {
            throw URLError(.badServerResponse)
        }
        let user = try snapshot.data(as: User.self)
        
        // Check if the user can level up today
          let calendar = Calendar.current
          if let lastLevelUp = user.lastLevelUp, calendar.isDateInToday(lastLevelUp) {
              // User has already leveled up today, handle appropriately
              throw NSError(domain: "LevelUpError", code: 100, userInfo: [NSLocalizedDescriptionKey: "You can only level up once per day."])
          }

        // Calculate new stats
        let newLevel = user.level + 1
        let newHp = user.hp + Int(Double(user.hp) * 0.1)  // Increase by 10%
        let newMp = user.mp + Int(Double(user.mp) * 0.1)  // Increase by 10%
        let newStrength = user.strength + 5  // Increment by 5 (example)
        let newHealth = user.health + 5  // Increment by 5
        let newAgility = user.agility + 5  // Increment by 5
        let newIntelligence = user.intelligence + 5  // Increment by 5
        let newSense = user.sense + 5  // Increment by 5
        let newMind = user.mind + 5  // Increment by 5

        // Update Firestore
        try await Firestore.firestore().collection("users").document(userId).updateData([
            "level": newLevel,
            "hp": newHp,
            "mp": newMp,
            "strength": newStrength,
            "health": newHealth,
            "agility": newAgility,
            "intelligence": newIntelligence,
            "sense": newSense,
            "mind": newMind,
            "lastLevelUp": Date()  // Record the current time as the last level-up time
        ])
    }
    
    func updateJob(newJob: String) async throws {
        guard let userId = AuthService.shared.userSession?.uid else {
            throw NSError(domain: "AuthServiceError", code: -1, userInfo: [NSLocalizedDescriptionKey: "User session not available."])
        }
        
        try await Firestore.firestore().collection("users").document(userId).updateData([
            "job": newJob
        ])
    }

    func updateName(newName: String) async throws {
        guard let userId = AuthService.shared.userSession?.uid else {
            throw NSError(domain: "AuthServiceError", code: -1, userInfo: [NSLocalizedDescriptionKey: "User session not available."])
        }
        
        try await Firestore.firestore().collection("users").document(userId).updateData([
            "name": newName
        ])
    }

    func updateTitle(newTitle: String) async throws {
        guard let userId = AuthService.shared.userSession?.uid else {
            throw NSError(domain: "AuthServiceError", code: -1, userInfo: [NSLocalizedDescriptionKey: "User session not available."])
        }
        
        try await Firestore.firestore().collection("users").document(userId).updateData([
            "title": newTitle
        ])
    }

    func updateAbility(newAbility: String) async throws {
        guard let userId = AuthService.shared.userSession?.uid else {
            throw NSError(domain: "AuthServiceError", code: -1, userInfo: [NSLocalizedDescriptionKey: "User session not available."])
        }
        
        try await Firestore.firestore().collection("users").document(userId).updateData([
            "ability": newAbility
        ])
    }

}
