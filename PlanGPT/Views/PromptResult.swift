//
//  PromptResult.swift
//  PlanGPT
//
//  Created by Lucian Prinz on 4/25/23.
//

import SwiftUI

struct PromptResult: View {
    @EnvironmentObject var tripService: PlanGPTTrip
    
    var days: [Day]
    @State var title = ""
    @State private var presentAlert = false
    
    
    var body: some View {
        ScrollView {
            VStack {
                HStack{
                    Spacer()
                    Button {
                        presentAlert = true
                    }label: {
                        Image(systemName: "bookmark")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:20)
                    }
                    .alert("Save Trip", isPresented: $presentAlert, actions: {
                        TextField("Enter a title for your trip", text: $title)
                        
                        Button("Save", action: {
                            tripService.createTrip(trip: Trip(
                                id: UUID().uuidString,
                                title: title,
                                days: days
                            ))
                        })
                        Button("Cancel", role: .cancel, action: {})
                    }, message: {
                        Text("Please enter a title for your trip")
                    })
                }.padding()
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
