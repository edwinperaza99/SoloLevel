//
//  AddGoalView.swift
//  SoloLevel
//
//  Created by Edwin on 4/25/24.
//

import SwiftData
import SwiftUI

struct AddGoalView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var notes = ""
    @State private var dueDate: Date? = nil
    @State private var showDueDatePicker = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Goal title:"){
                    TextField("Title", text: $title)
                }
                Section {
                    Button("Set a Due Date Now!") {
                        showDueDatePicker.toggle()
                    }
                    if showDueDatePicker {
                        DatePicker(
                            "Due Date",
                            selection: Binding(get: {
                                dueDate ?? Date() // Provide a current date if dueDate is nil
                            }, set: {
                                dueDate = $0
                            }),
                            displayedComponents: .date
                        )
                    }
                }
                
                Section("Notes:") {
                    TextEditor(text: $notes)
                }
                if !title.isEmpty{
                    Section {
                        Button("Save") {
                            let newGoal = Goal(title: title, notes: notes, dueDate: dueDate)
                            modelContext.insert(newGoal)
                            dismiss()
                        }
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    AddGoalView()
}
