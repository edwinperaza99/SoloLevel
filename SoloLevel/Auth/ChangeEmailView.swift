//
//  ChangeEmailView.swift
//  SoloLevel
//
//  Created by Edwin on 5/14/24.
//

import SwiftUI

struct ChangeEmailView: View {
    @Environment(\.dismiss) var dismiss
    @State private var newEmail = ""
    @State private var message = ""
    @State private var showingAlert = false
    
    var isEmailValid: Bool {
        let emailFormat = "(?:[A-Z0-9a-z._%+-]+)@(?:[A-Za-z0-9-]+\\.)+[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: newEmail)
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Change Email")
                .font(.title2)
                .fontWeight(.semibold)
                .textCase(.uppercase)
            Text("Enter your new email address")
                .font(.footnote)
                .foregroundStyle(.gray)
            HStack {
                Image(systemName: "envelope")
                    .fontWeight(.semibold)
                TextField("New Email", text: $newEmail)
                    .font(.subheadline)
                    .padding(12)
                    .cornerRadius(12)
            }
            .customInputFieldStyle()
            
            if !isEmailValid && !newEmail.isEmpty {
                Text("* Email is invalid")
                    .font(.caption)
                    .foregroundColor(.red)
                    .padding(.leading, 30)
            }
            
            Button {
                if isEmailValid {
                    changeEmail()
                } else {
                    message = "Please enter a valid email address."
                    showingAlert = true
                }
            } label: {
                Text("Change Email")
            }
            .customButtonStyle()
        }
        .padding()
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Change Email"),
                message: Text(message),
                dismissButton: .default(Text("OK"), action: {
                    if message == "Email has been updated successfully!" {
                        dismiss()
                    }
                })
            )
        }
        .preferredColorScheme(.dark)
    }

    private func changeEmail() {
        AuthService.shared.changeEmail(newEmail: newEmail) { result in
            switch result {
            case .success:
                message = "Email has been updated successfully!"
            case .failure(let error):
                message = error.localizedDescription
            }
            showingAlert = true
        }
    }
}

#Preview {
    ChangeEmailView()
}
