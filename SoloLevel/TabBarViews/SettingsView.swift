//
//  SettingsView.swift
//  SoloLevel
//
//  Created by csuftitan on 4/13/24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            Form {
                Section("Challenges") {
                    NavigationLink {
                        Text("Edit challenges")
                    }
                    NavigationLink {
                        Text("Change reset time")
                    }
                }
                Section("Player profile") {
                    NavigationLink {
                        Text("Change username")
                    }
                    NavigationLink {
                        Text("Change email")
                    }
                    NavigationLink {
                        Text("Change password")
                    }
                }
                Section("Stats"){
                    NavigationLink {
                        Text("Change job")
                    }
                    NavigationLink {
                        Text("Change titles")
                    }
                }
                Section("Logout") {
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

        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    SettingsView()
}
