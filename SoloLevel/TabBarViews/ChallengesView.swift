//
//  ChallengesView.swift
//  SoloLevel
//
//  Created by Edwin on 4/13/24.
//

import SwiftUI
import SwiftData


struct ChallengesView: View {
    @State private var showingAlert = false
    
//    timer related variables
    @State private var countdownTimer = ""
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var isWaveActive = false
    
// TODO: ADD CHALLENGES CODE
    @Query var challenges: [Challenge]
    
    private var allChallengesCompleted: Bool {
        !challenges.isEmpty && challenges.allSatisfy { $0.completed }
    }

    
    var body: some View {
        ZStack {
            VStack(spacing: 15) {
                QuestNotice()
                
                Text("Daily quest - Train to become a formidable combatant")
                    .customTextStyle()
                Text("Goals")
                    .customTextStyle()
                    .foregroundColor(.green)
//                daily challenges go in here
                ScrollView {
                    ForEach(challenges.indices, id: \.self) { index in
                        let challenge = challenges[index] // Get the challenge at the current index
                        HStack {
                            Text("- \(challenge.text)")
                            Spacer()
                            HStack {
                                Picker("", selection: Binding(
                                    get: { challenge.achieved }, // Getter
                                    set: { newValue in 
                                        challenges[index].achieved = newValue
                                    } // Setter
                                )) {
                                    ForEach(0...challenge.quantity, id: \.self) { number in
                                        Text("\(number)").tag(number)
                                    }
                                }
                                .pickerStyle(.menu)
                                .accentColor(challenge.completed ? .white : .gray)
                                Text("\(challenge.quantity)")
                            }
                        }
                        .customTextStyle()
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
             
//                    button to collect xp only appears when challenges are completed
                Button("Level Up") {
                    Task {
                        do {
                            try await DatabaseManager.shared.levelUpUser()
                            // Show success message
                        } catch {
                            // Handle errors, perhaps by showing an alert
                            print("Error leveling up: \(error)")
                        }
                    }
                }
               .customButtonStyle()
               .opacity(allChallengesCompleted ? 1 : 0)
               .disabled(!allChallengesCompleted)
               .padding(.bottom, 16)
            
//                   .sheet(isPresented: $showLevelUpView) {
//                       LevelUpView()
//                   }
                
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
