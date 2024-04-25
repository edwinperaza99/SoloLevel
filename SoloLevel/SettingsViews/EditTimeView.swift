//
//  EditTimeView.swift
//  SoloLevel
//
//  Created by Edwin on 4/25/24.
//

import SwiftUI

struct EditTimeView: View {
    var body: some View {
        Form {
            DatePicker(LocalizedStringKey, selection: Binding<Date>)
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    EditTimeView()
}
