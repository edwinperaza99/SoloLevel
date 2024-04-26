//
//  AddGoalView.swift
//  SoloLevel
//
//  Created by Edwin on 4/25/24.
//

import SwiftUI

struct AddGoalView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var description = ""
//    @State private var dueDate: Date
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Goal title:"){
                    TextField("Title", text: $title)
                }
                Section("Notes:") {
                    TextEditor(text: $description)
                }
                Section {
                    Button("Save") {
//                    TODO: add description as well
                        let newGoal = Goal(title: title)
                        modelContext.insert(newGoal)
                        dismiss()
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
