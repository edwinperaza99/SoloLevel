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
    var dateCreated: Date
    var dueDate: Date?
    var completed: Bool
    var statusDescription: String {
      if completed {
          return "Completed"
      } else if let dueDate = dueDate, Date() > dueDate {
          return "Late"
      } else {
          return "In Progress"
      }
    }
    
    init(title: String, notes: String, dateCreated: Date = Date(), dueDate: Date? = nil, completed: Bool = false) {
          self.title = title
          self.notes = notes
          self.dateCreated = dateCreated
          self.dueDate = dueDate
          self.completed = completed
      }
    
    func dueDateDescription() -> String {
       if let dueDate = dueDate {
           let dateFormatter = DateFormatter()
           dateFormatter.dateStyle = .medium
           return dateFormatter.string(from: dueDate)
       } else {
           return "No due date"
       }
   }
}
