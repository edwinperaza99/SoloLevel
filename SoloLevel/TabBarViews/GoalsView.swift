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
                        HStack {
                           VStack(alignment: .leading, spacing: 4) {
                               Text(goal.title)
                                   .font(.headline)
                               Text(goal.statusDescription)
                                   .font(.subheadline)
                                   .foregroundColor(colorForStatus(goal.statusDescription))
                           }
                           Spacer()
                           Text(goal.dueDateDescription())
                               .font(.subheadline)
                               .foregroundColor(.secondary)
                       }
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
    
    private func colorForStatus(_ status: String) -> Color {
            switch status {
            case "Completed":
                return .green
            case "Late":
                return .red
            case "In Progress":
                return .yellow
            default:
                return .gray
            }
        }
}

#Preview {
    GoalsView()
}
