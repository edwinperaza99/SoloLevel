//
//  TabBar.swift
//  SoloLevel
//
//  Created by Edwin on 4/13/24.
//

import SwiftUI

struct TabBar: View {
    @State private var selectedTab = 0
    @State private var showScanView = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ProfileView()
                .tabItem { Label("Profile", systemImage: "person")}
            ChallengesView()
                .tabItem { Label("Challenges", systemImage: "dumbbell")}
            GoalsView()
                .tabItem { Label("Goals", systemImage: "flame") }
            SettingsView()
                .tabItem { Label("Settings", systemImage: "gear") }
            
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    TabBar()
}
