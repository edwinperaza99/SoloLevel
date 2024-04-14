//
//  GoalsView.swift
//  SoloLevel
//
//  Created by csuftitan on 4/13/24.
//

import SwiftUI

//just for testing
struct Goal: Identifiable {
    var id = UUID()
    var text: String
}

struct GoalsView: View {
//    just for testing
    @State private var goals = [
           Goal(text: "Run a marathon"),
           Goal(text: "Read 50 books this year"),
           Goal(text: "Learn to play the piano"),
           Goal(text: "Complete a SwiftUI course"),
           Goal(text: "Save more money")
       ]

    func deleteGoal(at offsets: IndexSet) {
           goals.remove(atOffsets: offsets)
       }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(goals) { goal in
                    Text(goal.text)
                }
                .onDelete(perform: deleteGoal)
            }
            .navigationTitle("Goals")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Add goal functionality here
                    }) {
                        Label("Add Goal", systemImage: "plus")
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    GoalsView()
}
