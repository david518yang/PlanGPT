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
            Text(day.location)
            Text(day.food)
            Text(day.sightseeing)
        }
    }
}

struct PromptResult_Previews: PreviewProvider {
    static var previews: some View {
        PromptResult(days: [Day(food: "f", location: "l", sightseeing: "s")])
    }
}
