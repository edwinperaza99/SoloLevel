//
//  LoginView.swift
//  SoloLevel
//
//  Created by Edwin on 4/13/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    @State private var isShowingPassword = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 15){
                Text("Welcome to Solo Level")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                Text("Please enter your account here")
                    .font(.footnote)
                    .foregroundStyle(.gray)
            }
            VStack(spacing: 15){
//                email input
                HStack {
                    Image(systemName: "envelope")
                        .fontWeight(.semibold)
                    TextField("Email", text: $email)
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
                        TextField("Password", text: $password)
                            .font(.subheadline)
                            .padding(12)
                            .cornerRadius(12)
                    } else {
                        SecureField("Password", text: $password)
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
//                            do something
                    } label: {
                        Text("Forgot password?")
                            .foregroundStyle(.red)
                            .padding(.trailing)
                    }
                }
//                Login buttons
                VStack(spacing: 15){
                    Button {
//                        do something
                    } label: {
                        Text("Login")
                    }
                    .customButtonStyle()
                    Button {
//                        do something
                    } label: {
                        Text("GitHub")
                    }
                    .customButtonStyle()
                    Button {
//                        do something
                    } label: {
                        Text("Google")
                    }
                    .customButtonStyle()
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
        .preferredColorScheme(.dark)
    }
}

#Preview {
    LoginView()
}