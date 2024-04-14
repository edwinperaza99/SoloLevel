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
    
//    timer related variables
    @State private var countdownTimer = ""
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var isWaveActive = false
    
    @State private var challenges: [Challenge] = [
        Challenge(text: "Push-ups", quantity: 100),
        Challenge(text: "Sit-ups", quantity: 100),
        Challenge(text: "Squats", quantity: 150),
        Challenge(text: "Run", quantity: 10)
    ]
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
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
//                timer diplay
                VStack(spacing: 10){
                    Image(systemName: isWaveActive ? "alarm" : "alarm.waves.left.and.right")
                      .aspectRatio(contentMode: .fit)
                      .font(.largeTitle)
                      .foregroundColor(isWaveActive ? .gray : .orange)
                      .onReceive(timer) { _ in
                          isWaveActive.toggle()
                          updateTimer()
                      }
                    Text("\(countdownTimer)")
                        .font(.title)
                        .foregroundColor(.gray)
                        .onReceive(timer) { _ in
                            updateTimer()
                        }
                }
            }
//            TODO: add alert for when challenge has not been met
            if showingAlert {
                CustomAlertView(showingAlert: $showingAlert)
                    .transition(.scale)
            }
        }
        .preferredColorScheme(.dark)
    }
    func updateTimer() {
        let calendar = Calendar.current
        let now = Date()
        let nextDay = calendar.startOfDay(for: calendar.date(byAdding: .day, value: 1, to: now)!)
        let timeLeft = nextDay.timeIntervalSince(now)
        let hours = Int(timeLeft) / 3600
        let minutes = Int(timeLeft) / 60 % 60
        let seconds = Int(timeLeft) % 60
        countdownTimer = String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
}

#Preview {
    ChallengesView()
}
