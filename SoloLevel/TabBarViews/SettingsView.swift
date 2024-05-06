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
                        Text("Edit challenges")
                    }
                }
                Section("Account") {
//                    NavigationLink(destination: ChangeEmailView()) {
                        Text("Change email")
//                    }
//                    NavigationLink(destination: ChangePasswordView()) {
                        Text("Change password")
//                    }
                }
                Section("Stats"){
                    NavigationLink(destination: ChangeJobView()) {
                        Text("Change job")
                    }
                    NavigationLink(destination: EditTitlesView()) {
                        Text("Change titles")
                    }
//                    NavigationLink(destination: ) {
                        Text("Change username")
//                    }
                }
                Section {
                    NavigationLink(destination: AboutView()) {
                        Text("About SoloLevel")
                    }
//                    NavigationLink(destination: InstructionsView()) {
                        Text("Instructions")
//                    }
                    Button {
                        AuthService.shared.signOut()
                        print("Button to log out pressed")
                    } label: {
                        HStack{
                            Image(systemName: "power")
                                .foregroundStyle(.red)
                            Text("Log out")
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
