//
//  EditChallengeView.swift
//  SoloLevel
//
//  Created by Edwin on 4/24/24.
//

import SwiftUI

struct EditChallengeView: View {
    @State var challengeTitle: String
    @State var repetitions: Int = 0

    var body: some View {
        Form {
            Section(header: Text("Challenge Title")) {
                TextField("Title", text: $challengeTitle)
            }
            Section(header: Text("Repetitions")) {
                Stepper(value: $repetitions, in: 0...100) {
                    Text("\(repetitions) repetitions")
                }
            }
        }
        .navigationTitle("Edit Challenge")
    }
}

#Preview {
    EditChallengeView(challengeTitle: "Challenge")
}
