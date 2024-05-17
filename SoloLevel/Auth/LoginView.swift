//
//  LoginView.swift
//  SoloLevel
//
//  Created by Edwin on 4/13/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    
    @State private var isShowingPassword = false
    @State private var showForgotPasswordSheet = false
    @State private var errorMessage: String?
    @State private var showAlert = false
    
    var isEmailValid: Bool {
       let emailFormat = "(?:[A-Z0-9a-z._%+-]+)@(?:[A-Za-z0-9-]+\\.)+[A-Za-z]{2,64}"
       let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
       return emailPredicate.evaluate(with: viewModel.email)
   }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 25){
                Text("Welcome to Solo Level")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                Text("Please enter your account here")
                    .font(.footnote)
                    .foregroundStyle(.gray)
            }
            VStack(spacing: 20){
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
//                    forgot password
                HStack {
                    Spacer()
                    Button{
                        showForgotPasswordSheet.toggle()
                    } label: {
                        Text("Forgot password?")
                            .foregroundStyle(.red)
                            .padding(.trailing)
                    }
                }
                // Error message
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.bottom, 10)
                }
//                Login buttons
                VStack(spacing: 15){
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        Button {
                            Task {
                                do {
                                    errorMessage = nil // Clear any previous error messages
                                    try await viewModel.login()
                                } catch {
                                    errorMessage = error.localizedDescription
                                    showAlert = true
                                }
                            }
                        } label: {
                            Text("Login")
                        }
                        .customButtonStyle()
                        .opacity(isEmailValid && !viewModel.password.isEmpty ? 1: 0.5)
                        .disabled(!isEmailValid && viewModel.password.isEmpty)
                    }
                }
//                sign up message
                HStack {
                    Text("You are not a registered player yet?")
                    NavigationLink {
                        SignupView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        Text("Sign Up")
                            .foregroundColor(.red)
                    }
                }
                .font(.subheadline)
            }
        }
        .sheet(isPresented: $showForgotPasswordSheet) {
            ForgotPasswordView()
        }
        .alert(isPresented: $showAlert) {
             Alert(
                 title: Text("Login Error"),
                 message: Text(errorMessage ?? "An unknown error occurred."),
                 dismissButton: .default(Text("OK"))
             )
         }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    LoginView()
}
