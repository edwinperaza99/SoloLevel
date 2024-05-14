//
//  ForgotPasswordView.swift
//  SoloLevel
//
//  Created by csuftitan on 5/14/24.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State private var email = ""
    @State private var message = ""
    @State private var showingAlert = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Reset Password")
                .font(.title2)
                .fontWeight(.semibold)
                .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
            Text("You will receive an email to reset your password")
                .font(.footnote)
                .foregroundStyle(.gray)
            HStack {
                Image(systemName: "envelope")
                    .fontWeight(.semibold)
                TextField("Email", text: $email)
                    .font(.subheadline)
                    .padding(12)
                    .cornerRadius(12)
            }
            .customInputFieldStyle()

            Button{
                sendPasswordReset()
            } label: {
                Text("Reset Password")
            }
            .customButtonStyle()
        }
        .padding()
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Password Reset"), message: Text(message), dismissButton: .default(Text("OK")))
        }
        .preferredColorScheme(.dark)
    }

    private func sendPasswordReset() {
        AuthService.shared.sendPasswordReset(email: email) { result in
            switch result {
            case .success:
                message = "Password reset email sent!"
            case .failure(let error):
                message = error.localizedDescription
            }
            showingAlert = true
        }
    }
}

#Preview {
    ForgotPasswordView()
}
