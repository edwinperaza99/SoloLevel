//
//  GoalsView.swift
//  SoloLevel
//
//  Created by Edwin on 4/13/24.
//

import SwiftData
import SwiftUI

struct GoalsList: View {
    @Environment(\.modelContext) var modelContext
    @Query var goals: [Goal]
    
    func deleteGoal(at offsets: IndexSet) {
        for offset in offsets {
            let goal = goals[offset]
            modelContext.delete(goal)
        }
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

    
    var body: some View {
        if goals.isEmpty {
            ContentUnavailableView("No Goals Set", systemImage: "exclamationmark.triangle", description: Text("Start adding your new goals."))
                .padding()
       }
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
                       Text(goal.daysLeft)
                           .font(.subheadline)
                           .foregroundColor(.secondary)
                   }
                }
            }
            .onDelete(perform: deleteGoal)
        }
    }
    init(sortOrder: [SortDescriptor<Goal>]) {
        _goals = Query(sort: sortOrder)
    }
}

struct GoalsView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var sortOrder = [
        SortDescriptor(\Goal.dueDate),
        SortDescriptor(\Goal.title),
    ]
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationStack {
            GoalsList(sortOrder: sortOrder)
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
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Sort by Title")
                                .tag([
                                    SortDescriptor(\Goal.title),
                                    SortDescriptor(\Goal.dueDate),
                                ])
                            Text("Sort by Due Date")
                                .tag([
                                    SortDescriptor(\Goal.dueDate),
                                    SortDescriptor(\Goal.title)
                                ])
                            Text("Sort by Creation Date")
                                .tag([
                                    SortDescriptor(\Goal.dateCreated),
                                    SortDescriptor(\Goal.title)
                                ])
                        }
                    }
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
