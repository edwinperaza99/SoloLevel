//
//  SignupView.swift
//  SoloLevel
//
//  Created by Edwin on 4/13/24.
//

import SwiftUI

struct SignupView: View {
    @StateObject var viewModel = RegistrationViewModel()
    
    @State private var isShowingPassword = false
    @State private var showAlert = false
    @State private var errorMessage: String?
    
    @Environment(\.dismiss) private var dismiss
    
    var isPasswordValidLength: Bool {
        return viewModel.password.count >= 6
    }
    var hasNumber: Bool {
        return viewModel.password.contains(where: {$0.isNumber})
    }
    var hasUppercase: Bool {
        return viewModel.password.contains(where: {$0.isUppercase})
    }
    var hasLowercase: Bool {
        return viewModel.password.contains(where: {$0.isLowercase})
    }
    var isPasswordValid: Bool {
        return isPasswordValidLength && hasNumber && hasLowercase && hasUppercase
    }
    var isEmailValid: Bool {
           let emailFormat = "(?:[A-Z0-9a-z._%+-]+)@(?:[A-Za-z0-9-]+\\.)+[A-Za-z]{2,64}"
           let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
           return emailPredicate.evaluate(with: viewModel.email)
       }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 15){
                Text("Create your player id today")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                Text("Please set your credentials")
                    .font(.footnote)
                    .foregroundStyle(.gray)
            }
            VStack(spacing: 15){
//                email input
                HStack {
                    Image(systemName: "envelope")
                        .fontWeight(.semibold)
                    TextField("Email", text: $viewModel.email)
                        .font(.subheadline)
                        .padding(12)
                        .cornerRadius(12)
                }
                .customInputFieldStyle()
                if !isEmailValid && !viewModel.email.isEmpty {
                 Text("*email is invalid")
                     .font(.caption)
                     .foregroundColor(.red)
                }
//                password input
                HStack {
                    Image(systemName: "lock")
                        .fontWeight(.semibold)
                    if isShowingPassword {
                        TextField("Password", text: $viewModel.password)
                            .font(.subheadline)
                            .padding(12)
                            .cornerRadius(12)
                    } else {
                        SecureField("Password", text: $viewModel.password)
                            .font(.subheadline)
                            .padding(12)
                            .cornerRadius(12)
                    }
                    Button {
//                        show password
                        isShowingPassword.toggle()
                    } label: {
                        Image(systemName: isShowingPassword ? "eye": "eye.slash")
                            .foregroundColor(.gray)
                    }
                }
                .customInputFieldStyle()
                VStack{
                    Text("Your password must contain:")
                        .font(.callout)
                        .foregroundColor(.white)
                    HStack {
                        Image(systemName: isPasswordValidLength ? "checkmark.circle.fill" : "checkmark.circle")
                            .foregroundColor(isPasswordValidLength ? .blue : .gray)
                        Text("At least 6 characters")
                    }
                    HStack {
                        Image(systemName: hasNumber ? "checkmark.circle.fill" : "checkmark.circle")
                            .foregroundColor(hasNumber ? .blue : .gray)
                        Text("At least 1 number")
                    }
                    HStack {
                        Image(systemName: hasUppercase ? "checkmark.circle.fill" : "checkmark.circle")
                            .foregroundColor(hasUppercase ? .blue : .gray)
                        Text("At least 1 uppercase character")
                    }
                    HStack {
                        Image(systemName: hasLowercase ? "checkmark.circle.fill" : "checkmark.circle")
                            .foregroundColor(hasLowercase ? .blue : .gray)
                        Text("At least 1 lowercase character")
                    }
                    
                }
                .font(.footnote)
                .foregroundColor(.gray)
                // Error message
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.bottom, 10)
                }
//                Sign up button
                VStack(spacing: 15){
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        Button {
                           Task {
                               do {
                                   errorMessage = nil // Clear any previous error messages
                                   try await viewModel.createUser()
                               } catch {
                                   errorMessage = error.localizedDescription
                                   showAlert = true
                               }
                           }
                       } label: {
                            Text("REGISTER")
                        }
                        .customButtonStyle()
                        .opacity(isPasswordValid  && isEmailValid ? 1: 0.5)
                        .disabled(!(isPasswordValid && isEmailValid))
                    }
                }
                HStack {
                    Text("Already have an account?")
                    Button(action: {dismiss()}, label: {Text("Log In")
                        .foregroundColor(.red)})
                }
                .font(.subheadline)
                
            }
        }
        .alert(isPresented: $showAlert) {
           Alert(
               title: Text("Sign Up Error"),
               message: Text(errorMessage ?? "An unknown error occurred."),
               dismissButton: .default(Text("OK"))
           )
       }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    SignupView()
}
