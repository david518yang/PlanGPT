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
            Text(day.Location)
            Text(day.Food)
            Text(day.Sightseeing)
        }
    }
}

struct PromptResult_Previews: PreviewProvider {
    static var previews: some View {
        PromptResult(days: [Day(Food: "f", Location: "l", Sightseeing: "s")])
    }
}
