//
//  ContentView.swift
//  SoloLevel
//
//  Created by Edwin on 4/12/24.
//

import SwiftUI

struct CustomAlertView: View {
    @Binding var showingAlert: Bool
    
    var body: some View {
        ZStack{
            Color(.black)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Notice()
                Text("You don't really want to decline")
                    .customTextStyle()
                Text("Do you?")
                    .customTextStyle()
                Button("DISMISS") {
                    showingAlert = false
                }
                .customButtonStyle()
                //                .padding(.horizontal)
                //                .padding(.vertical, 8)
                //                .background(Color.blue)
                //                .foregroundColor(.white)
                //                .cornerRadius(10)
            }
//            .padding()
            //            .background(Color.blue)
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
            }
        }
}

struct ContentView: View {
    @State private var showingAlert = false
    @State private var showingLogin = false

    
    var body: some View {
        ZStack {
            VStack(spacing: 40) {
//                Spacer()
//                VStack(spacing: 40){
                    Notice()
                    
                    Text("You now qualify to become a player.")
                        .customTextStyle()
                    Text("Do you accept?")
                        .customTextStyle()
                    HStack(spacing: 30){
                        Button {
                            // login
                            showingLogin = true
                        }label: {
                            Text("ACCEPT")
                                .foregroundColor(.white)
                        }
                        .customButtonStyle()
                        
                        Button {
                            showingAlert = true
                        }label: {
                            Text("DECLINE")
                                .foregroundColor(.white)
                        }
                        .customButtonStyle()
                    }
//                }
//                .alert(isPresented: $showingAlert){
//                    Alert(
//                        title: Text("Solo Level"),
//                        message:  Text("You don't really want to decline"),
//                        dismissButton: .default(Text("Take me back"))
//                        
//                        
//                    )
//                }
//                
                
//                Spacer()
            }
            .fullScreenCover(isPresented: $showingLogin, content: {
                LoginView()
            })
            if showingAlert {
                CustomAlertView(showingAlert: $showingAlert)
                    .transition(.scale)
            }
        }
        .preferredColorScheme(.dark)
    }
}


#Preview {
    ContentView()
}
