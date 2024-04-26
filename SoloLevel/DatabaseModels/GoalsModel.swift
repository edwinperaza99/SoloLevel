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
//    var date created
//    var due date
    init(title: String) {
        self.title = title
    }
}
