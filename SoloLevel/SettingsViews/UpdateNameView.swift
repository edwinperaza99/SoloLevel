//
//  UpdateNameView.swift
//  SoloLevel
//
//  Created by Edwin on 5/14/24.
//

import SwiftUI

struct UpdateNameView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Change Name")
                .font(.title2)
                .fontWeight(.semibold)
                .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
            Text("Choose a new name!")
                .font(.footnote)
                .foregroundStyle(.gray)
            HStack {
                Image(systemName: "gamecontroller")
                    .fontWeight(.semibold)
                TextField("Name", text: $name)
                    .font(.subheadline)
                    .padding(12)
                    .cornerRadius(12)
            }
            .customInputFieldStyle()
            if name.isEmpty {
                Text("*name can't be empty")
                    .font(.caption)
                    .foregroundColor(.red)
            }
            Button {
                Task {
                    await changeName()
                }
            } label: {
                Text("Update Name")
            }
            .customButtonStyle()
            .opacity(!name.isEmpty ? 1: 0.5)
            .disabled(name.isEmpty)
        }
        .preferredColorScheme(.dark)
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Notification"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"), action: {
                    if alertMessage == "Name updated successfully!" {
                        dismiss()
                    }
                })
            )
        }
    }
    
    func changeName() async {
        do {
            try await DatabaseManager.shared.updateName(newName: name)
            alertMessage = "Name updated successfully!"
        } catch {
            alertMessage = error.localizedDescription
        }
        showingAlert = true
    }
}

#Preview {
    UpdateNameView()
}
