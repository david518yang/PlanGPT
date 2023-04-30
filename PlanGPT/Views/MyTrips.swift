//
//  MyTrips.swift
//  PlanGPT
//
//  Created by Lucian Prinz on 4/26/23.
//

import SwiftUI

struct MyTrips: View {
    
    @State var userId: String = ""
    @State var trips: [Trip] = []
    @State var fetching: Bool = false
    @EnvironmentObject var tripService: PlanGPTTrip
    
    var body: some View {
        NavigationView {
            VStack {
                if fetching {
                    ProgressView()
                } else if trips.count == 0 {
                    Text("You have no trips saved")
                } else {
                    Text("My Trips")
                        .font(.title)
                        .fontWeight(.bold)
                    List(trips) { trip in
                        NavigationLink {
                            PromptResult(days: trip.days, showButton: false)
                        } label: {
                            Text(trip.title)
                        }
                    }
                }
            }.task {
                fetching = true
                do {
                    trips = try await tripService.fetchTrips(userId: userId)
                    fetching = false
                } catch {
                    fetching = false
                }
            }.onAppear {
                if let userData = UserDefaults.standard.data(forKey: "currentUser"),
                   let user = try? JSONDecoder().decode(User.self, from: userData) {
                    userId = user.uid
                }
            }
        }
    }
}

struct MyTrips_Previews: PreviewProvider {
    static var previews: some View {
        MyTrips()
    }
}
