//
//  ProfileView.swift
//  SoloLevel
//
//  Created by Edwin on 4/13/24.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var user: User?
    @Published var isLoading = false
    @Published var errorMessage = ""
    @Published var lastLevelUp: Date?

    func fetchUserProfile() {
        isLoading = true
        Task {
            do {
                user = try await DatabaseManager.shared.getUserProfile()
                isLoading = false
                lastLevelUp = user?.lastLevelUp
            } catch {
                errorMessage = "Failed to load profile: \(error.localizedDescription)"
                isLoading = false
            }
        }
    }
}

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    private var columns: [GridItem] = [
           GridItem(.flexible(), spacing: 90),
           GridItem(.flexible())
       ]
    @State private var selectedTitle = "Shadow Monarch"
    let titles = ["Shadow Monarch", "Light Monarch", "Fragment of light"]
    @State private var selectedSkill = "Increased damage"
    let skills = ["Increased damage", "Increased speed", "Dagger damage"]
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
               ProgressView()
           } else if let user = viewModel.user {
               userProfileView(user)
           } else {
               Text("No user data available")
           }
        }
        .onAppear {
              viewModel.fetchUserProfile()
          }
        .preferredColorScheme(.dark)
    }
    
    private func userProfileView(_ user: User) -> some View {
        VStack(spacing: 0) {
            Stats()
//                player information here
            LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
                Text("Name: \(user.name)")
                Text("Level: \(user.level)")
                Text("Job: \(user.job)")
                Text("Fatigue: 0")
                Text("Title: \(user.title)")
                Spacer()
                Text("HP: \(user.hp)")
                
           }
                .customTextStyleSM()
                .padding(.leading, 40)
                .padding(.bottom, 10)
            Text("MP: \(user.mp)")
                .AlignLeft()
                .padding(.leading, 40)
                .padding(.bottom, 40)
//                mana bar
//            VStack {
//                Text("MP: \(user.mp)")
//                    .AlignLeft()
//                RectangleDivider()
//            }
            .customTextStyleSM()
//            .padding(.leading, 40)
//                just a divider
            RectangleDivider()
//                player stats here
            LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
                Text("Strength: \(user.strength)")
                Text("Health: \(user.health)")
                Text("Agility: \(user.agility)")
                Text("Intelligence: \(user.intelligence)")
                Text("Sense: \(user.sense)")
                Text("Mind: \(user.mind)")
           }
            .customTextStyleSM()
            .padding(.leading, 40)
//                just a divider
            RectangleDivider()
//                current skill
            VStack {
//                    skills here
                Text("\(user.ability)")
                    .AlignLeft()
                .AlignLeft()
                Text("ACTIVATED")
                    .foregroundColor(.green)
                    .AlignLeft()
            }
            .AlignLeft()
            .customTextStyleSM()
            .padding(.leading, 40)
        }

    }
}



#Preview {
    ProfileView()
}
