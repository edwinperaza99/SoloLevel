//
//  QuestNotice.swift
//  SoloLevel
//
//  Created by Edwin on 4/13/24.
//

import Foundation
import SwiftUI

struct QuestNotice: View {
    var body: some View {
        VStack(spacing: 0){
            RectangleDivider()
            HStack(spacing: 10) {
                Image(systemName: "exclamationmark.circle")
                Text("Quest Info")
            }
            .font(.largeTitle)
            .textCase(.uppercase)
            RectangleDivider()
        }
    }
}

struct Stats: View {
    var body: some View {
        VStack(spacing: 0){
            RectangleDivider()
            Text("stats")
            .font(.largeTitle)
            .textCase(.uppercase)
            RectangleDivider()
        }
    }
}


