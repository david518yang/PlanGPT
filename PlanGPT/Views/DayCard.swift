//
//  DayCard.swift
//  PlanGPT
//
//  Created by Lucian Prinz on 4/26/23.
//

import SwiftUI

struct DayCard: View {
    var day: Day
    var index: Int
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack () {
                Text("Day \(index)")
                    .font(.title2)
                    .fontWeight(.medium)
                Spacer()
                Text(day.location)
            }
            Spacer().frame(height: 10)
            VStack (alignment: .leading) {
                Text("Food")
                    .font(.headline)
                    .fontWeight(.medium)
                Text(day.food)
            }
            Spacer().frame(height: 10)
            VStack (alignment: .leading) {
                Text("Activity")
                    .font(.headline)
                    .fontWeight(.medium)
                Text(day.sightseeing)
            }
        }.padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
            )
            .padding()

    }
}

struct DayCard_Previews: PreviewProvider {
    static var previews: some View {
        DayCard(day: Day(day:0,food: "Dinner at In-N-Out Burger", location: "Los Angeles, CA", sightseeing: "Hollywood Walk of Fame", latitude: 34.1017, longitude: 118.3403), index: 1)
    }
}
