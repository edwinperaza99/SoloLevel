//
//  GoalsView.swift
//  SoloLevel
//
//  Created by Edwin on 4/13/24.
//

import SwiftData
import SwiftUI


struct GoalsView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\Goal.title),
//        SortDescriptor(\Goal.description)
    ]) var goals: [Goal]
    
    @State private var showingAddScreen = false

    func deleteGoal(at offsets: IndexSet) {
        for offset in offsets {
            let goal = goals[offset]
            modelContext.delete(goal)
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(goals) { goal in
                    NavigationLink(value: goal){
                        Text(goal.title)
                    }
                }
                .onDelete(perform: deleteGoal)
            }
            .navigationTitle("Goals")
            .navigationDestination(for: Goal.self) { goal in
               GoalView(goal: goal)
           }
            .scrollBounceBehavior(.basedOnSize)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
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
