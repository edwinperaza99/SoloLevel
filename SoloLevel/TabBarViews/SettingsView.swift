//
//  SettingsView.swift
//  SoloLevel
//
//  Created by Edwin on 4/13/24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            Form {
                Section("Challenges") {
                    NavigationLink(destination: EditChallengesView()) {
                        Text("Edit Challenges")
                    }
                }
                Section("Account") {
                    NavigationLink(destination: ChangeEmailView()) {
                        Text("Change Email")
                    }
                    NavigationLink(destination: ForgotPasswordView()) {
                        Text("Change Password")
                    }
                }
                Section("Stats"){
                    NavigationLink(destination: UpdateNameView()) {
                        Text("Change Name")
                    }
                    NavigationLink(destination: UpdateJobView()) {
                        Text("Change Job")
                    }
                    NavigationLink(destination: UpdateTitleView()) {
                        Text("Change Title")
                    }
                    NavigationLink(destination: UpdateAbilityView()){
                        Text("Change Ability")
                    }
                }
                Section {
                    NavigationLink(destination: AboutView()) {
                        Text("About SoloLevel")
                    }
                    NavigationLink(destination: InstructionsView()) {
                        Text("Instructions")
                    }
                    Button {
                        AuthService.shared.signOut()
                        print("Button to log out pressed")
                    } label: {
                        HStack{
                            Image(systemName: "power")
                                .foregroundStyle(.red)
                            Text("Log Out")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .scrollBounceBehavior(.basedOnSize)

        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    SettingsView()
}
