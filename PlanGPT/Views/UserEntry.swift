//
//  UserEntry.swift
//  PlanGPT
//
//  Created by David Yang on 4/25/23.
//

import SwiftUI
import ConfettiSwiftUI

struct UserEntry: View {
    @StateObject var apiService = APIService.shared
    @State var chatCompletion: ChatCompletion?
    @State var errorMessage: String?
    @State var days: [Day]?
    @State var refresh = 0
    
    @State private var isLoading: Bool = false
    @State private var prompt: String = ""
    
    @State var startPoint = ""
    @State var endDestination = ""
    @State var duration = 1
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image(systemName: "map")
                        .foregroundColor(.blue)
                        .font(.system(size:25))
                    
                    Text("PlanGPT")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                        .font(.system(size:25))
                    
                    Image(systemName: "fork.knife.circle")
                        .foregroundColor(.blue)
                        .font(.system(size:25))
                }
            
                    
                Form {
                    Section(header: Text("Starting Point")) {
                        TextField("Enter starting point",text:$startPoint)
                    }
                    
                    Section(header: Text("End Destination")) {
                        TextField("Enter end destination", text:$endDestination)
                    }
                    
                    Section() {
                        Picker("Trip Duration (days)", selection: $duration) {
                            ForEach(1..<8, id: \.self) { num in
                                Text(num.description).tag(num)
                            }
                        }
                    }
                    
                    Section(header: Text("Actions")) {
                        Button(action: {
                            Task {
                                isLoading = true // Set loading status
                                errorMessage = nil
                                if startPoint.isEmpty || endDestination.isEmpty {
                                    isLoading = false
                                    errorMessage = "Please specify a start and end location"
                                    return
                                }
                                do {
                                    let completion = try await apiService.getCompletion(prompt: "Pretend you are planning a road trip. Provide a list of exactly and no more than \(duration) locations, the first being \(startPoint) and the last being \(endDestination). The other locations must be along the general path of the route from \(startPoint) to \(endDestination). You cannot move away from the end location and you cannot backtrack and you must not divert from the path between the first and last location. For each city, find any restaurant in the location, and any sightseeing attraction. For each day, follow this structure: { food: String, location: String, sightseeing: String, latitude: Double, longitude: Double } Return only a sample JSON array of each Day object with no extra spaces and no extra text other than the array.")
                                    days = completion
                                    refresh+=1
                                } catch APIService.APIErrors.fetchError {
                                    errorMessage = "Error fething data, try again..."
                                } catch APIService.APIErrors.decodeError {
                                    errorMessage = "Error decoding data, try again..."
                                } catch APIService.APIErrors.parseError {
                                    errorMessage = "Error parsing data, try again..."
                                } catch {
                                    errorMessage = "An unknown error occured, try again..."
                                }
                                isLoading = false // Reset loading status
                            }
                        }, label: {
                                Text(isLoading ? "Loading..." : "Plan Trip")
                        }).disabled(isLoading)
                        
                        
                        
                        if let error = errorMessage {
                            Text(error).foregroundColor(.red)
                        }
                        
                        if let days = days {
                            if !isLoading {
                                NavigationLink("Click here to view your trip", destination: PromptResult(days:days, showButton: true))
                            }
                        }
                    }
                }
                .confettiCannon(counter: $refresh, num:1, confettis: [.text("\u{1F697}"), .text("\u{1F5FA}"), .text("\u{1F4CD}")], confettiSize: 30, repetitions: 10, repetitionInterval: 0.1)
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [.white, .blue, .black]), startPoint: .top, endPoint: .bottom)
            )
        }
    }

}

struct UserEntry_Previews: PreviewProvider {
    static var previews: some View {
        UserEntry()
    }
}
