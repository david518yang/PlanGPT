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
    var showButton: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                HStack{
                    Text("Your Trip")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    if (showButton) {
                        if let userData = UserDefaults.standard.data(forKey: "currentUser"),
                           let user = try? JSONDecoder().decode(User.self, from: userData) {
                            Button {
                                presentAlert = true
                            }label: {
                                HStack {
                                    Text("Save Trip")
                                        .foregroundColor(.blue)
                                    Image(systemName: "bookmark")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width:20)
                                }
                            }
                            .alert("Save Trip", isPresented: $presentAlert, actions: {
                                TextField("Enter a title for your trip", text: $title)
                                
                                Button("Save", action: {
                                    tripService.createTrip(trip: Trip(
                                        id: UUID().uuidString,
                                        title: title,
                                        days: days,
                                        userId: user.uid
                                    ))
                                })
                                Button("Cancel", role: .cancel, action: {})
                            }, message: {
                                Text("Please enter a title for your trip")
                            })
                        }
                    }
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
        PromptResult(days: [Day(day:1,food: "Dinner at In-N-Out Burger", location: "Los Angeles, CA", sightseeing: "Hollywood Walk of Fame", coords: [1,2])], showButton: true)
    }
}
