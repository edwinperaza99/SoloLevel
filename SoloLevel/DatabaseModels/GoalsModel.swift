//
//  GoalsModel.swift
//  SoloLevel
//
//  Created by Edwin on 4/15/24.
//

import Foundation
import SwiftData

@Model
class Goal {
    var title: String
    var notes: String
//    var date created
//    var due date
    init(title: String, notes: String) {
        self.title = title
        self.notes = notes
    }
}
