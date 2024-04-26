//
//  GoalsView.swift
//  SoloLevel
//
//  Created by Edwin on 4/13/24.
//

import SwiftUI

//just for testing
//struct Goal: Identifiable {
//    var id = UUID()
//    var text: String
//}

struct GoalsView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var showingAddScreen = false
    
//    just for testing
    @State private var goals = [
           Goal(title: "Run a marathon"),
           Goal(title: "Read 50 books this year"),
           Goal(title: "Learn to play the piano"),
           Goal(title: "Complete a SwiftUI course"),
           Goal(title: "Save more money")
       ]

    func deleteGoal(at offsets: IndexSet) {
           goals.remove(atOffsets: offsets)
       }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(goals) { goal in
                    Text(goal.title)
                }
                .onDelete(perform: deleteGoal)
            }
            .navigationTitle("Goals")
            .scrollBounceBehavior(.basedOnSize)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Add goal functionality here
                        showingAddScreen.toggle()
                    }) {
                        Label("Add Goal", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddGoalView()
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    GoalsView()
}
