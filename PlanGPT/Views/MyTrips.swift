//
//  MyTrips.swift
//  PlanGPT
//
//  Created by Lucian Prinz on 4/26/23.
//

import SwiftUI

struct MyTrips: View {
    var trips: [Trip]
    
    var body: some View {
        NavigationView {
            ScrollView{
                trips.forEach() { trip in
                    
                }
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
