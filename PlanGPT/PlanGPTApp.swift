//
//  PlanGPTApp.swift
//  PlanGPT
//
//  Created by David Yang on 4/24/23.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct PlanGPTApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(PlanGPTTrip())
        }
    }
}
