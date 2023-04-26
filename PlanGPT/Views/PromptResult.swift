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
        ForEach(days, id: \.self) { day in
            if let dayNum = days.firstIndex(of:day) {
                Text("Day \(dayNum+1)")
            }
            Text("Location: \(day.location)")
            Text("Food: \(day.food)")
            Text("Sightseeing: \(day.sightseeing)")
            Spacer()
        }
    }
}

struct PromptResult_Previews: PreviewProvider {
    static var previews: some View {
        PromptResult(days: [Day(food: "f", location: "l", sightseeing: "s")])
    }
}
