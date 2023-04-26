//
//  UserEntry.swift
//  PlanGPT
//
//  Created by David Yang on 4/25/23.
//

import SwiftUI

struct UserEntry: View {
    @StateObject var apiService = APIService.shared
    @State var chatCompletion: ChatCompletion?
    @State var errorMessage: String?
    @State var days: [Day]?
    
    @State private var isLoading: Bool = false
    @State private var prompt: String = ""
    
    @State var startPoint = ""
    @State var endDestination = ""
    @State var duration = 1
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Starting Point")) {
                        TextField("Starting Point",text:$startPoint)
                    }
                    
                    Section(header: Text("End Destination")) {
                        TextField("End Destination", text:$endDestination)
                    }
                    
                    Section(header: Text("Trip Duration")) {
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
                                    let completion = try await apiService.getCompletion(prompt: "Plan a \(duration) day(s) long trip day by day starting from \(startPoint) and ending at \(endDestination). For each day of the trip, find one place for food, and one sightseeing attraction. Store each day in an object only containing food, location, and sightseeing. Return a JSON array of each Day object with no extra spaces.")
                                    days = completion
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
                            HStack {
                                Spacer()
                                Text(isLoading ? "Loading..." : "Plan Trip")
                                Spacer()
                            }
                        }).disabled(isLoading)
                        
                        if let error = errorMessage {
                            Text(error).foregroundColor(.red)
                        }
                        
                        if let days = days {
                            NavigationLink("Your trip has been planned! Click to view", destination: PromptResult(days:days))
                        }
                    }
                }
            }
        }
    }
}

struct UserEntry_Previews: PreviewProvider {
    static var previews: some View {
        UserEntry()
    }
}
