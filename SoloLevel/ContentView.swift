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
                .cornerRadius(10)
            }
//            can test colors for view easily here
//          .background(Color.blue)
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
            }
        }
}

struct ContentView: View {
    @State private var showingAlert = false
    @State private var showingLogin = false
    @StateObject var viewModel = ContentViewModel()
    @State private var isVStackVisible: Bool = true

    
    var body: some View {
        VStack {
            if isVStackVisible {
                ZStack {
                    VStack(spacing: 40) {
                            Notice()
                            Text("You now qualify to become a player.")
                                .customTextStyle()
                            Text("Do you accept?")
                                .customTextStyle()
                            HStack(spacing: 30){
                                Button {
                                    // login
                                    UserDefaults.standard.set(true, forKey: "Onboarding")
                                    UserDefaults.standard.synchronize()
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
            } else {
                Group {
//                    check if "$" is really necessary
                    if viewModel.userSession != nil {
                        TabBar()
                    } else {
                        LoginView()
                    }
                }
            }
        }
        .onAppear(perform: {
            if UserDefaults.standard.bool(forKey: "Onboarding"){
                isVStackVisible = false
            }
        })
    }
}


#Preview {
    ContentView()
}
