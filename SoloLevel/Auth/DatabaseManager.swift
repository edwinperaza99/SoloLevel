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
    
    private func randomStat(in range: ClosedRange<Int>) -> Int {
        return Int.random(in: range)
    }

     private func randomPercentage(in range: ClosedRange<Double>) -> Double {
         return Double.random(in: range)
     }
     
    
    func createNewUser() async throws{
        guard let userId = AuthService.shared.userSession?.uid,
               let email = AuthService.shared.userSession?.email else {
             throw NSError(domain: "AuthServiceError", code: -1, userInfo: [NSLocalizedDescriptionKey: "User session not available."])
         }
        // Derive initial name from email (everything before the "@" symbol)
        let name = email.components(separatedBy: "@").first ?? "Unknown"
        
        // Define initial values for other fields
        let initialLevel = 1
        
        // Set the last level-up date to a date far in the past (e.g., January 1, 2000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        let lastLevelUpDate = dateFormatter.date(from: "2000/01/01 00:00") ?? Date(timeIntervalSince1970: 0)
        
        let newUser = User(userId: userId,
                            email: email,
                            dateCreated: Date(),
                            level: initialLevel,
                            name: name,
                            job: "Unknown",
                            title: "Unknown",
                            hp: randomStat(in: 250...350),
                            mp: randomStat(in: 100...300),
                            strength: randomStat(in: 7...12),
                            health: randomStat(in: 7...12),
                            agility: randomStat(in: 7...12),
                            intelligence: randomStat(in: 7...12),
                            sense: randomStat(in: 7...12),
                            mind: randomStat(in: 7...12),
                            ability: "Unknown",
                            lastLevelUp: lastLevelUpDate)
        
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
        let hpIncreasePercentage = randomPercentage(in: 0.10...0.30)  // Random percentage between 10% and 30%
        let mpIncreasePercentage = randomPercentage(in: 0.10...0.30)  // Random percentage between 10% and 30%
        let newHp = user.hp + Int(Double(user.hp) * hpIncreasePercentage)
        let newMp = user.mp + Int(Double(user.mp) * mpIncreasePercentage)
        let newStrength = user.strength + randomStat(in: 3...5)
        let newHealth = user.health + randomStat(in: 3...5)
        let newAgility = user.agility + randomStat(in: 3...5)
        let newIntelligence = user.intelligence + randomStat(in: 3...5)
        let newSense = user.sense + randomStat(in: 3...5)
        let newMind = user.mind + randomStat(in: 3...5)

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
