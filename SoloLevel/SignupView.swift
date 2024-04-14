//
//  SignupView.swift
//  SoloLevel
//
//  Created by csuftitan on 4/13/24.
//

import SwiftUI

struct SignupView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isShowingPassword = false
    
    @Environment(\.dismiss) private var dismiss
    
    var isPasswordValidLength: Bool {
        return password.count >= 6
    }
    var hasNumber: Bool {
        return password.contains(where: {$0.isNumber})
    }
    var hasUppercase: Bool {
        return password.contains(where: {$0.isUppercase})
    }
    var hasLowercase: Bool {
        return password.contains(where: {$0.isLowercase})
    }
    var isPasswordValid: Bool {
        return isPasswordValidLength && hasNumber && hasLowercase && hasUppercase
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
//                Sign up button
                VStack(spacing: 15){
                    Button {
//                        do something
                    } label: {
                        Text("REGISTER")
                    }
                    .customButtonStyle()
                    .opacity(isPasswordValid ? 1: 0.5)
                    .disabled(!isPasswordValid)
                }
                HStack {
                    Text("Already have an account?")
                    Button(action: {dismiss()}, label: {Text("Log In")
                        .foregroundColor(.red)})
                }
                .font(.subheadline)
                
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    SignupView()
}
