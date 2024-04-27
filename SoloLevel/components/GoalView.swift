//
//  GoalView.swift
//  SoloLevel
//
//  Created by Edwin on 4/26/24.
//

import SwiftData
import SwiftUI

struct GoalView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    @State private var editingNotes = false
    
    @Bindable var goal: Goal
    
    var body: some View {
        Form {
            Section("Goal:") {
                TextField(goal.title, text: $goal.title)
            }
            Section("Notes:") {
                Button(action: {
                    editingNotes.toggle()
                }) {
                    Text(goal.notes)
                        .foregroundColor(.primary)
                }

            }
        }
        .navigationTitle("Edit Goal")
        .navigationBarTitleDisplayMode(.inline)
        .preferredColorScheme(.dark)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete goal", isPresented: $showingDeleteAlert) {
              Button("Delete", role: .destructive, action: deleteGoal)
              Button("Cancel", role: .cancel) { }
          } message: {
              Text("Are you sure?")
          }
        .toolbar {
            Button("Delete this goal", systemImage: "trash") {
                showingDeleteAlert = true
            }
        }
        .sheet(isPresented: $editingNotes) {
            EditNotesView(goal: goal)
        }
    }
    func deleteGoal() {
           modelContext.delete(goal)
           dismiss()
       }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Goal.self, configurations: config)
        let example = Goal(title: "Test Goal", notes: "some notes")

        return GoalView(goal: example)
            .modelContainer(container)
   } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
   }
}
