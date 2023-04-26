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
    @State var duration = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Starting Point")) {
                    TextField("Starting Point",text:$startPoint)
                }
                
                Section(header: Text("Trip Duration")) {
                    Picker("Trip Duration (days)", selection: $duration) {
                        ForEach(1..<7, id: \.self) { num in
                            Text(num.description)
                        }
                    }
                }
                
                Section(header: Text("End Destination")) {
                    TextField("End Destination", text:$endDestination)
                }
                
                Button("Fetch Completion") {
                    Task {
                        isLoading = true // Set loading status
                        do {
                            let completion = try await apiService.getCompletion(prompt: "Plan me a \(duration) day trip starting from \(startPoint), and ending in \(endDestination)")
                            days = completion
                        } catch APIService.APIErrors.fetchError {
                            errorMessage = "Error fething data, try again..."
                        } catch APIService.APIErrors.decodeError {
                            errorMessage = "Error decoding data, try again..."
                        } catch {
                            errorMessage = "An unknown error occured, try again..."
                        }
                        isLoading = false // Reset loading status
                    }
                }.buttonStyle(.borderedProminent)
                
            }
            
            
            if isLoading {
                ProgressView()
            }
            
            if let completion = days {
                NavigationLink("Your response is ready! Click to view", destination: PromptResult(days:days!))
            }
            
            if let error = errorMessage {
                Text(error).foregroundColor(.red)
            }
        }.padding()
    }
}

struct UserEntry_Previews: PreviewProvider {
    static var previews: some View {
        UserEntry()
    }
}
