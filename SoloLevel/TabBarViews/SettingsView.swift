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
            List {
                Section("Challenges") {
                    Text("Edit challenges")
                }
                Section("Player profile") {
                    Text("Change username")
                    Text("Change email")
                    Text("Change password")
                }
                Section("Stats"){
                    Text("Change job")
                    Text("Change")
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
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    SettingsView()
}
