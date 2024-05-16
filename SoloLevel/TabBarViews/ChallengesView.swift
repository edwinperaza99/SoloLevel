//
//  ChallengesView.swift
//  SoloLevel
//
//  Created by Edwin on 4/13/24.
//

import SwiftUI
import SwiftData


struct ChallengesView: View {
    @ObservedObject private var viewModel = ProfileViewModel()
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
    
    @State private var lastLevelUpDate: Date?
    @State private var statusMessage: String = "- If the daily quest remains incomplete, penalties may be given"
    
    var canLevelUp: Bool {
         // Debug prints to check values
         print("All Challenges Completed: \(allChallengesCompleted)")
         print("Last Level Up Date: \(String(describing: lastLevelUpDate))")
         
         if let lastLevelUp = lastLevelUpDate {
             let localLastLevelUp = Calendar.current.startOfDay(for: lastLevelUp)
             let today = Calendar.current.startOfDay(for: Date())
             return allChallengesCompleted && (localLastLevelUp != today)
         }
         return allChallengesCompleted
     }

    
    var body: some View {
        ZStack {
            if challenges.isEmpty {
                ContentUnavailableView("No Challenges", systemImage: "exclamationmark.triangle", description: Text("Add new challenges in the settings tab."))
                    .padding()
           }
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
                (Text("Caution! ").foregroundColor(.red) + Text(statusMessage))
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
                            for index in challenges.indices {
                                 challenges[index].achieved = 0
                             }
                            try await DatabaseManager.shared.levelUpUser()
                            statusMessage = "- Complete your challenges tomorrow"
                            // Show success message
                        } catch {
                            // Handle errors, perhaps by showing an alert
                            print("Error leveling up: \(error)")
                            statusMessage = "- You already leveled up today, come back tomorrow"
                        }
                    }
                }
               .customButtonStyle()
               .opacity(canLevelUp ? 1 : 0)
               .disabled(!canLevelUp)
               .padding(.bottom, 16)
               .onAppear {
                   viewModel.fetchUserProfile()
                   guard let lastLevelUpDate = viewModel.user?.lastLevelUp else {
                       return
                   }
                   updateStatusMessage()
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
    
    func updateStatusMessage() {
          if canLevelUp {
              statusMessage = "- All challenges completed, you can level up now"
          } else if let lastLevelUp = lastLevelUpDate, Calendar.current.isDateInToday(lastLevelUp) {
              statusMessage = "- You already leveled up today, come back tomorrow"
          } else if allChallengesCompleted {
              statusMessage = "- All challenges completed, you can level up now"
          } else {
              statusMessage = "- If the daily quest remains incomplete, penalties may be given"
          }
      }
}

#Preview {
    ChallengesView()
}
