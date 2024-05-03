//
//  AddChallengeView.swift
//  SoloLevel
//
//  Created by Edwin on 5/3/24.
//

import SwiftData
import SwiftUI

struct AddChallengeView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var text = ""
    @State private var quantity = 0
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Challenge text:"){
                    TextField("Title", text: $text)
                }
                Section("Challenge repetitions/quantity:") {
                    TextField("Enter the number of repetitions", value: $quantity, formatter: NumberFormatter())
                       .keyboardType(.numberPad) // Set keyboard type to number pad
                }
//                Section("Optional measurement:") {
//                    TextField("Enter measurement", text: $measurement)
//                }
                if !text.isEmpty && quantity > 0 {
                    Section {
                        Button("Save") {
                            let newChallenge = Challenge(text: text, quantity: quantity)
                            modelContext.insert(newChallenge)
                            dismiss()
                        }
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    AddChallengeView()
}
