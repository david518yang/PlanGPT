//
//  MyTrips.swift
//  PlanGPT
//
//  Created by Lucian Prinz on 4/26/23.
//

import SwiftUI

struct MyTrips: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Your trips will appear here")
            }
            .navigationBarTitle("My Trips", displayMode: .inline)
        }
    }
}

struct MyTrips_Previews: PreviewProvider {
    static var previews: some View {
        MyTrips()
    }
}
