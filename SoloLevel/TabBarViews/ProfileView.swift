//
//  ProfileView.swift
//  SoloLevel
//
//  Created by csuftitan on 4/13/24.
//

import SwiftUI

struct ProfileView: View {
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
            VStack(spacing: 0) {
                Stats()
//                player information here
                LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
                   Text("Name: Edwin")
                   Text("Level: 100")
                   Text("Job: Student")
                   Text("Fatigue: 0")
               }
                .customTextStyleSM()
                .padding(.leading, 40)
                HStack(spacing: 0) {
                    Text("Title:")
                    Picker("Title:", selection: $selectedTitle) {
                        ForEach(titles, id: \.self) { title in
                            Text(title).tag(title)
                        }
                    }
                    .pickerStyle(.menu)
                    .fixedSize()
                }
                .AlignLeft()
                .padding(.leading, 40)
                .foregroundColor(.white)
                .customTextStyleSM()
//                hp bar
                VStack {
                    Text("HP: 5114")
                        .AlignLeft()
                    RectangleDivider()
                }
                .customTextStyleSM()
                .padding(.leading, 40)
//                mana bar
                VStack {
                    Text("MP: 548")
                        .AlignLeft()
                    RectangleDivider()
                }
                .customTextStyleSM()
                .padding(.leading, 40)
//                just a divider
                RectangleDivider()
//                player stats here
                LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
                   Text("Strength: 72")
                   Text("Health: 43")
                   Text("Agility: 82")
                   Text("Intelligence: 39")
                   Text("Sense: 69")
                   Text("Mind: 23")
               }
                .customTextStyleSM()
                .padding(.leading, 40)
//                just a divider
                RectangleDivider()
//                current skill
                VStack {
//                    skills here
                    Picker("", selection: $selectedSkill) {
                        ForEach(skills, id: \.self) { skill in
                            Text(skill).tag(skill)
                        }
                    }
                    .padding(.leading, -10)
                    .pickerStyle(.menu)
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
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ProfileView()
}
