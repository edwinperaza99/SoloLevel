//
//  Notice.swift
//  SoloLevel
//
//  Created by Edwin on 4/13/24.
//

import Foundation
import SwiftUI

struct RectangleDivider: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(Color(red: 0.2, green: 0.2, blue: 0.3))
            .padding(.vertical)
            .padding(.horizontal, 50)
    }
}

struct Notice: View {
    var body: some View {
        VStack(spacing: 0){
            RectangleDivider()
            HStack(spacing: 10) {
                Image(systemName: "exclamationmark.circle")
                Text("Notice")
            }
            .font(.largeTitle)
            .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
            RectangleDivider()
        }
    }
}
