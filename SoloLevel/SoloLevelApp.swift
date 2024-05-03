//
//  SoloLevelApp.swift
//  SoloLevel
//
//  Created by Edwin on 4/12/24.
//

import SwiftUI
import SwiftData
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct SoloLevelApp: App {
//    snippet of code to clear UserDefaults for testing purposes
//    init() {
//           if let appDomain = Bundle.main.bundleIdentifier {
//               UserDefaults.standard.removePersistentDomain(forName: appDomain)
//               UserDefaults.standard.synchronize()
//           }
//       }
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//    init() {
//            // Clear UserDefaults for testing purposes
//            if let appDomain = Bundle.main.bundleIdentifier {
//                UserDefaults.standard.removePersistentDomain(forName: appDomain)
//                UserDefaults.standard.synchronize()
//            }
//            
//            // Delete all instances of the Goal model
//            do {
//                try modelContext.delete(model: Goal.self)
//            } catch {
//                print("Failed to clear all Goal data.")
//            }
//        }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Goal.self, Challenges.self])
//        .modelContainer(for: Challenges.self)
    }
}
