//
//  EditNotesView.swift
//  SoloLevel
//
//  Created by csuftitan on 4/26/24.
//

import SwiftData
import SwiftUI

struct EditNotesView: View {
    @Bindable var goal: Goal
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Section {
                Text("Write some notes")
                    .font(.title2)
                    .foregroundColor(.secondary)
            }
            Section {
                TextEditor(text: $goal.notes)
            }
            Section {
                Button("Save") {
                    dismiss()
                }
            }
        }
        .padding()
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Goal.self, configurations: config)
        let example = Goal(title: "Test Goal", notes: "some notes")

        return EditNotesView(goal: example)
            .modelContainer(container)
   } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
   }
}
