//
//  ChallengesModel.swift
//  SoloLevel
//
//  Created by Edwin on 4/15/24.
//

import SwiftData
import Foundation

class Challenge1: Identifiable, ObservableObject {
    var id = UUID()
    var text: String
    var quantity: Int
    var measure: String?
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
class Challenge {
    var text: String
    var quantity: Int
    var achieved: Int
    var completed: Bool
    var measure: String?
    
    init(text: String, quantity: Int, achieved: Int = 0, completed: Bool = false, measure: String? = nil) {
        self.text = text
        self.quantity = quantity
        self.achieved = achieved
        self.completed = completed
        self.measure = measure
    }
}
