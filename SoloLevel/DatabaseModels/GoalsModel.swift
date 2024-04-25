//
//  GoalsModel.swift
//  SoloLevel
//
//  Created by Edwin on 4/15/24.
//

import Foundation

class Goals: Identifiable, ObservableObject {
    var id = UUID()
    var text: String
//    var date created
//    var due date
    init(text: String) {
        self.text = text
    }
}
