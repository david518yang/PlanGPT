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
                                    let completion = try await apiService.getCompletion(prompt: "Plan a road trip day by day starting from \(startPoint) with stops along the way eventually ending at \(endDestination). There must be exactly \(duration) days and locations must be in geographical order. For each day of the trip, find one notable restaurant in the location for food, and one sightseeing attraction. Store each day in an object only containing food, location, and sightseeing. Return only a JSON array of each Day object with no extra spaces.")
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
