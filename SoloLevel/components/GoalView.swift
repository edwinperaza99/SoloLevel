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
    
    let goal: Goal
    
    var body: some View {
        ScrollView {
            Section("Goal title:"){
                Text(goal.title)
            }
            Section("Notes:") {
                Text(goal.notes)
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Goal.self, configurations: config)
        let example = Goal(title: "Test Book", notes: "some notes")

        return GoalView(goal: example)
            .modelContainer(container)
   } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
   }
}
