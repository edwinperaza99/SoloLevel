//
//  InstructionsView.swift
//  SoloLevel
//
//  Created by Edwin on 5/7/24.
//

import SwiftUI

struct InstructionsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Instruction 1: Set Daily Challenges
                Text("1. Set Daily Challenges")
                    .font(.headline)
                    .bold()
                Text("Start your day by setting personal challenges in various categories such as fitness, reading, or skill development. Make sure the challenges are achievable but meaningful.")
                    .font(.body)
                    .multilineTextAlignment(.leading)

                // Instruction 2: Update Progress
                Text("2. Update Progress")
                    .font(.headline)
                    .bold()
                Text("Throughout the day, update your progress in completing your daily challenges. Keeping track will help you stay focused.")
                    .font(.body)
                    .multilineTextAlignment(.leading)

                // Instruction 3: Complete Challenges
                Text("3. Complete Challenges")
                    .font(.headline)
                    .bold()
                Text("Finish your challenges before the day ends to claim your experience points. Consistency is key!")
                    .font(.body)
                    .multilineTextAlignment(.leading)

                // Instruction 4: Level Up and Upgrade
                Text("4. Level Up and Upgrade")
                    .font(.headline)
                    .bold()
                Text("As you gain experience points and level up, use your upgraded stats to improve your skills. Keep leveling up to reach your goals!")
                    .font(.body)
                    .multilineTextAlignment(.leading)
                Image(.sung2)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
            }
            .padding()
        }
        .navigationTitle("How to Solo Level")
    }
}

#Preview {
    InstructionsView()
}
