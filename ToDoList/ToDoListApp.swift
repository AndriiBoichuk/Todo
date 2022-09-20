//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by user on 10.02.2022.
//

import SwiftUI
import Firebase
import Intents

@main
struct ToDoListApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @ObservedObject var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainView()
                    .id(appState.rootViewId)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(appState)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        return true
    }
    
    func donateIntent() {
        let intent = AddTargetIntent()
        intent.suggestedInvocationPhrase = "Add New Target"
        let interaction = INInteraction(intent: intent, response: nil)
        
        interaction.donate { error in
            if error != nil {
                if let error = error as NSError? {
                    print(error.localizedDescription)
                } else {
                    print("Successfully donated interaction")
                }
            }
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
    }
}
