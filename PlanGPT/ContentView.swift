//
//  ContentView.swift
//  PlanGPT
//
//  Created by David Yang on 4/24/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("signedIn") var signedIn = false
    
    var body: some View {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
