//
//  EditChallengesView.swift
//  SoloLevel
//
//  Created by Edwin on 4/24/24.
//

import SwiftData
import SwiftUI

struct ChallengesList: View {
    @Environment(\.modelContext) var modelContext
    @Query var challenges: [Challenge]

    func deleteChallenge(at offsets: IndexSet) {
        for offset in offsets {
            let challenge = challenges[offset]
            modelContext.delete(challenge)
        }
    }
    var body: some View {
        if challenges.isEmpty {
            ContentUnavailableView("No Challenges", systemImage: "exclamationmark.triangle", description: Text("Add new challenges now."))
                .padding()
       }
        List {
           ForEach(challenges) { challenge in
               NavigationLink(destination: EditChallengeView(challenge: challenge)){
                  Text(challenge.text)
                      .font(.headline)
               }
           }
           .onDelete(perform: deleteChallenge)
       }
    }
    init(sortOrder: [SortDescriptor<Challenge>]) {
           _challenges = Query(sort: sortOrder)
       }
}

struct EditChallengesView: View {
    @State private var sortOrder = [
           SortDescriptor(\Challenge.text),
           SortDescriptor(\Challenge.quantity),
       ]
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationStack {
            ChallengesList(sortOrder: sortOrder)
            .navigationTitle("Edit Challenges")
            .scrollBounceBehavior(.basedOnSize)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Sort by Text")
                                .tag([
                                    SortDescriptor(\Challenge.text),
                                    SortDescriptor(\Challenge.quantity),
                                ])
                            Text("Sort by Repetitions")
                                .tag([
                                    SortDescriptor(\Challenge.quantity),
                                    SortDescriptor(\Challenge.text)
                                ])
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddScreen.toggle()
                    }) {
                        Label("Add Challenge", systemImage: "plus")
                    }
                }
         
            }
            .sheet(isPresented: $showingAddScreen) {
                AddChallengeView()
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    EditChallengesView()
}
