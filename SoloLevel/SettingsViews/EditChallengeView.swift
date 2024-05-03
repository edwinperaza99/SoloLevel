//
//  EditChallengeView.swift
//  SoloLevel
//
//  Created by Edwin on 4/24/24.
//

import SwiftData
import SwiftUI

struct EditChallengeView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    @Bindable var challenge: Challenge
    
    var body: some View {
        Form {
            Section("Challenge:") {
                TextField(challenge.text, text: $challenge.text)
            }
            Section("Repetitions/quantity:"){
                TextField("\(challenge.quantity)", value: $challenge.quantity, formatter: NumberFormatter())
            }
//            Section("Measurement:"){
//                TextField(challenge.measure, text: $challenge.measure)
//            }
        }
        .navigationTitle("Edit Challenge")
//        .navigationBarTitleDisplayMode(.inline)
        .preferredColorScheme(.dark)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete challenge", isPresented: $showingDeleteAlert) {
              Button("Delete", role: .destructive, action: deleteChallenge)
              Button("Cancel", role: .cancel) { }
          } message: {
              Text("Are you sure?")
          }
        .toolbar {
            Button("Delete this challenge", systemImage: "trash") {
                showingDeleteAlert = true
            }
        }
    }
    func deleteChallenge() {
           modelContext.delete(challenge)
           dismiss()
       }
}

#Preview {
    do {
       let config = ModelConfiguration(isStoredInMemoryOnly: true)
       let container = try ModelContainer(for: Goal.self, configurations: config)
        let example = Challenge(text: "Test challenge", quantity: 20)

       return EditChallengeView(challenge: example)
           .modelContainer(container)
  } catch {
       return Text("Failed to create preview: \(error.localizedDescription)")
  }
}
