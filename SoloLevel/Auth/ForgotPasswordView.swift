//
//  ForgotPasswordView.swift
//  SoloLevel
//
//  Created by Edwin on 5/14/24.
//

import SwiftUI

struct ForgotPasswordView: View {
    @Environment(\.dismiss) var dismiss
    @State private var email = ""
    @State private var message = ""
    @State private var showingAlert = false
    
    var isEmailValid: Bool {
       let emailFormat = "(?:[A-Z0-9a-z._%+-]+)@(?:[A-Za-z0-9-]+\\.)+[A-Za-z]{2,64}"
       let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
       return emailPredicate.evaluate(with: email)
   }

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
            if !isEmailValid && !email.isEmpty {
             Text("*email is invalid")
                 .font(.caption)
                 .foregroundColor(.red)
            }
            
            Button{
                sendPasswordReset()
            } label: {
                Text("Reset Password")
            }
            .customButtonStyle()
            .opacity(isEmailValid ? 1: 0.5)
            .disabled(!(isEmailValid))
        }
        .padding()
        .alert(isPresented: $showingAlert) {
           Alert(
               title: Text("Password Reset"),
               message: Text(message),
               dismissButton: .default(Text("OK"), action: {
                   if message == "Password reset email sent!" {
                       dismiss()
                   }
               })
           )
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
