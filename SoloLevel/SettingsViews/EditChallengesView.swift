//
//  EditChallengesView.swift
//  SoloLevel
//
//  Created by Edwin on 4/24/24.
//

import SwiftUI

struct EditChallengesView: View {
    let challenges = ["Challenge 1", "Challenge 2", "Challenge 3", "Challenge 4"]

    var body: some View {
        List {
            ForEach(challenges, id: \.self) { challenge in
                NavigationLink(destination: EditChallengeView(challengeTitle: challenge)) {
                    Text(challenge)
                }
            }
        }
        .navigationTitle("Edit Challenges")
        .preferredColorScheme(.dark)
    }
}

#Preview {
    EditChallengesView()
}
