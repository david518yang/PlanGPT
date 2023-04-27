//
//  PromptResult.swift
//  PlanGPT
//
//  Created by Lucian Prinz on 4/25/23.
//

import SwiftUI

struct PromptResult: View {
    var days: [Day]
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(days, id: \.self) { day in
                    if let dayNum = days.firstIndex(of:day) {
                        DayCard(day: day, index: dayNum+1)
                    }
                    Spacer()
                }
            }
        }

    }
}

struct PromptResult_Previews: PreviewProvider {
    static var previews: some View {
        PromptResult(days: [Day(day:1,food: "Dinner at In-N-Out Burger", location: "Los Angeles, CA", sightseeing: "Hollywood Walk of Fame")])
    }
}
