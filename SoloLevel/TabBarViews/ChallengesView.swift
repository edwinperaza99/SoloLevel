//
//  ChallengesView.swift
//  SoloLevel
//
//  Created by csuftitan on 4/13/24.
//

import SwiftUI

struct Challenge: Identifiable {
    var id = UUID()
    var text: String
    var quantity: Int
}

struct ChallengesView: View {
    @State private var showingAlert = false

    @State private var challenges: [Challenge] = [
        Challenge(text: "Push-ups", quantity: 100),
        Challenge(text: "Sit-ups", quantity: 100),
        Challenge(text: "Squats", quantity: 150),
        Challenge(text: "Run", quantity: 10)
    ]
    
    var body: some View {
        ZStack {
            VStack(spacing: 40) {
                Spacer()
                QuestNotice()
                
                Text("Daily quest - Train to become a formidable combatant")
                    .customTextStyle()
                Text("Goals")
                    .customTextStyle()
                    .foregroundColor(.green)
//                daily challenges go in here
                VStack(spacing: 20) {
                    ForEach(challenges) { challenge in
                        HStack{
                            Text("-\(challenge.text)")
                            Spacer()
                            Text("\(challenge.quantity)")
                        }
                    }
                }
                .font(.title2)
//                alert message here
                (Text("Caution!").foregroundColor(.red) + Text(" - If the daily quest remains incomplete, penalties may be given"))
                    .customTextStyle()
                Spacer()
            }
//            TODO: add alert for when challenge has not been met
            if showingAlert {
                CustomAlertView(showingAlert: $showingAlert)
                    .transition(.scale)
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ChallengesView()
}
