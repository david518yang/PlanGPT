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
    @AppStorage("signedIn") var signedIn = false
    
    var body: some Scene {
        WindowGroup {
            if !signedIn {
                Login()
            } else {
                TabView {
                    UserEntry()
                        .tabItem {
                            Label("Plan", systemImage: "map")
                        }
                    MyTrips()
                        .tabItem {
                            Label("My Trips", systemImage: "list.bullet.clipboard.fill")
                        }
                    Account()
                        .tabItem {
                            Label("Account", systemImage: "person.crop.circle")
                        }
                }
            }
        }
    }
}
