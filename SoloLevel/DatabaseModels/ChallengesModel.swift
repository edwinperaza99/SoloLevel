//
//  ChallengesModel.swift
//  SoloLevel
//
//  Created by Edwin on 4/15/24.
//

import SwiftData
import Foundation

@Model
class Challenge {
    var text: String
    var quantity: Int
    var achieved: Int
    var completed: Bool {
        achieved == quantity
    }
    var measure: String?
    
    init(text: String, quantity: Int, achieved: Int = 0, measure: String? = nil) {
        self.text = text
        self.quantity = quantity
        self.achieved = achieved
        self.measure = measure
    }
}
