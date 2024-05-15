//
//  UpdateAbilityView.swift
//  SoloLevel
//
//  Created by Edwin on 5/14/24.
//

import SwiftUI

struct UpdateAbilityView: View {
    @Environment(\.dismiss) var dismiss
    @State private var ability = ""
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Change Ability")
                .font(.title2)
                .fontWeight(.semibold)
                .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
            Text("Choose a new ability!")
                .font(.footnote)
                .foregroundStyle(.gray)
            HStack {
                Image(systemName: "theatermask.and.paintbrush")
                    .fontWeight(.semibold)
                TextField("Ability", text: $ability)
                    .font(.subheadline)
                    .padding(12)
                    .cornerRadius(12)
            }
            .customInputFieldStyle()
            if ability.isEmpty {
                Text("*ability can't be empty")
                    .font(.caption)
                    .foregroundColor(.red)
            }
            Button {
                Task {
                    await changeAbility()
                }
            } label: {
                Text("Update Ability")
            }
            .customButtonStyle()
            .opacity(!ability.isEmpty ? 1: 0.5)
            .disabled(ability.isEmpty)
        }
        .preferredColorScheme(.dark)
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Notification"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"), action: {
                    if alertMessage == "Ability updated successfully!" {
                        dismiss()
                    }
                })
            )
        }
    }
    
    func changeAbility() async {
        do {
            try await DatabaseManager.shared.updateAbility(newAbility: ability)
            alertMessage = "Ability updated successfully!"
        } catch {
            alertMessage = error.localizedDescription
        }
        showingAlert = true
    }
}

#Preview {
    UpdateAbilityView()
}
