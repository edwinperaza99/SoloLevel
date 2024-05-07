//
//  AboutView.swift
//  SoloLevel
//
//  Created by csuftitan on 5/6/24.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack() {
                Text("Solo Level is a self-improvement app inspired by the themes of progression and personal growth, akin to the journey of Sung Jinwoo in the popular manwha and anime series *Solo Leveling*. The app integrates a gamified level system where users can set daily challenges and earn experience points upon completion, with a focus on fostering consistency and discipline in personal goals.")
                    .font(.body)
                    .padding(.leading, 10)
                
                Image(.sung)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                
                // Features Section
                Text("Features")
                    .font(.title)
                    .bold()
                
                VStack(alignment: .leading, spacing: 8) {
                    FeatureItemView(title: "Challenges", description: "Set and track daily personal challenges in various categories such as fitness, reading, or skill development.")
                    FeatureItemView(title: "Leveling System", description: "Gain experience points and level up by consistently meeting your daily goals.")
                    FeatureItemView(title: "Progress Tracking", description: "Visualize your progress with statistics and level progression to keep track of your improvement over time.")
                    FeatureItemView(title: "User Profile", description: "Personalize your experience with a customizable profile, including a profile picture and username.")
                }
                .padding(.leading, 10)
                
                Spacer()
            }
        }
        .navigationTitle("About")
    }
}

struct FeatureItemView: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .bold()
            Text(description)
                .font(.body)
                .multilineTextAlignment(.leading)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    AboutView()
}
