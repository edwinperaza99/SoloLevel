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
//                Login buttons
                VStack(spacing: 15){
                    Button {
                        Task {
                            try await viewModel.login()
                        }
                    } label: {
                        Text("Login")
                    }
                    .customButtonStyle()
//                    Button {
////                        do something
//                    } label: {
//                        Text("GitHub")
//                    }
//                    .customButtonStyle()
//                    Button {
////                        do something
//                    } label: {
//                        Text("Google")
//                    }
//                    .customButtonStyle()
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
        .preferredColorScheme(.dark)
    }
}

#Preview {
    LoginView()
}
