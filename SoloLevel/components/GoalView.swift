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
    @State private var showDueDatePicker = false
    
    @Bindable var goal: Goal
    
    var body: some View {
        Form {
            Section("Goal:") {
                TextField(goal.title, text: $goal.title)
                Toggle(isOn: $goal.completed) {
                    Text(goal.completed ? "Completed" : "Mark as Completed")
                }
                Label("Created: \(goal.dateCreatedDescription())", systemImage: "calendar")
                HStack {
                    Label("Due:", systemImage: "calendar.badge.clock")
                    Button(goal.dueDateDescription()) {
                        showDueDatePicker.toggle()
                    }
                }
                if showDueDatePicker {
                  DatePicker(
                      "Change due date",
                      selection: Binding(get: {
                          goal.dueDate ?? Date() // Provide a default date if dueDate is nil
                      }, set: {
                          goal.dueDate = $0
                      }),
                      displayedComponents: .date
                  ).datePickerStyle(GraphicalDatePickerStyle()) // Makes the picker more visually engaging
              }
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
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Delete this goal", systemImage: "trash") {
                    showingDeleteAlert = true
                }
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
