//
//  UpdateJobView.swift
//  SoloLevel
//
//  Created by Edwin on 5/14/24.
//

import SwiftUI

struct UpdateJobView: View {
    @Environment(\.dismiss) var dismiss
    @State private var job = ""
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Change Job")
                .font(.title2)
                .fontWeight(.semibold)
                .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
            Text("Choose a new Job!")
                .font(.footnote)
                .foregroundStyle(.gray)
            HStack {
                Image(systemName: "wrench.and.screwdriver")
                    .fontWeight(.semibold)
                TextField("Job", text: $job)
                    .font(.subheadline)
                    .padding(12)
                    .cornerRadius(12)
            }
            .customInputFieldStyle()
            if job.isEmpty {
                Text("*job can't be empty")
                    .font(.caption)
                    .foregroundColor(.red)
            }
            Button {
                Task {
                    await changeJob()
                }
            } label: {
                Text("Update Job")
            }
            .customButtonStyle()
            .opacity(!job.isEmpty ? 1: 0.5)
            .disabled(job.isEmpty)
        }
        .preferredColorScheme(.dark)
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Notification"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"), action: {
                    if alertMessage == "Job updated successfully!" {
                        dismiss()
                    }
                })
            )
        }
    }
    
    func changeJob() async {
        do {
            try await DatabaseManager.shared.updateJob(newJob: job)
            alertMessage = "Job updated successfully!"
        } catch {
            alertMessage = error.localizedDescription
        }
        showingAlert = true
    }
}

#Preview {
    UpdateJobView()
}
