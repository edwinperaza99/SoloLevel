//
//  UpdateTitleView.swift
//  SoloLevel
//
//  Created by Edwin on 5/14/24.
//

import SwiftUI

struct UpdateTitleView: View {
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Change Title")
                .font(.title2)
                .fontWeight(.semibold)
                .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
            Text("Choose a fitting title for you!")
                .font(.footnote)
                .foregroundStyle(.gray)
            HStack {
                Image(systemName: "graduationcap")
                    .fontWeight(.semibold)
                TextField("Title", text: $title)
                    .font(.subheadline)
                    .padding(12)
                    .cornerRadius(12)
            }
            .customInputFieldStyle()
            if title.isEmpty {
                Text("*title can't be empty")
                    .font(.caption)
                    .foregroundColor(.red)
            }
            Button {
                Task {
                    await changeTitle()
                }
            } label: {
                Text("Update Title")
            }
            .customButtonStyle()
            .opacity(!title.isEmpty ? 1: 0.5)
            .disabled(title.isEmpty)
        }
        .preferredColorScheme(.dark)
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Notification"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"), action: {
                    if alertMessage == "Title updated successfully!" {
                        dismiss()
                    }
                })
            )
        }
    }
    
    func changeTitle() async {
        do {
            try await DatabaseManager.shared.updateTitle(newTitle: title)
            alertMessage = "Title updated successfully!"
        } catch {
            alertMessage = error.localizedDescription
        }
        showingAlert = true
    }
}

#Preview {
    UpdateTitleView()
}
