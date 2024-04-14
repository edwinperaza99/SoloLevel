//
//  TabBar.swift
//  SoloLevel
//
//  Created by Edwin on 4/13/24.
//

import SwiftUI

struct TabBar: View {
    @State private var selectedTab = 1
    @State private var showScanView = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ProfileView()
                .tabItem { Label("Profile", systemImage: "person")}
                .tag(0)
            ChallengesView()
                .tabItem { Label("Challenges", systemImage: "dumbbell")}
                .tag(1)
            GoalsView()
                .tabItem { Label("Goals", systemImage: "flame") }
                .tag(2)
            SettingsView()
                .tabItem { Label("Settings", systemImage: "gear") }
                .tag(3)
            
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    TabBar()
}
