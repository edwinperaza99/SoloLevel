//
//  ChallengesModel.swift
//  SoloLevel
//
//  Created by Edwin on 4/15/24.
//

import SwiftData
import Foundation

class Challenge: Identifiable, ObservableObject {
    var id = UUID()
    var text: String
    var quantity: Int
    @Published var achieved: Int = 0
    var completed: Bool {
        achieved == quantity
    }
    
    init(text: String, quantity: Int) {
           self.text = text
           self.quantity = quantity
       }
}

@Model 
class Challenges {
    var challenge: [Challenge]
    var dueDate: Date
    init(challenge: [Challenge], dueDate: Date) {
        self.challenge = challenge
        self.dueDate = dueDate
    }
}
