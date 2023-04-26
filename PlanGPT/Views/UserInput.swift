////
////  UserInput.swift
////  PlanGPT
////
////  Created by Lucian Prinz on 4/24/23.
////
//
//import SwiftUI
//
//struct UserInput: View {
//    @StateObject var apiService = APIService.shared
//    @State var chatCompletion: ChatCompletion?
//    @State var errorMessage: String?
//
//    @State private var isLoading: Bool = false
//    @State private var prompt: String = ""
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                TextField(
//                    "Enter your prompt",
//                    text: $prompt
//                )
//                .textFieldStyle(.roundedBorder)
//
//                Button("Fetch Completion") {
//                    Task {
//                        isLoading = true // Set loading status
//                        do {
//                            let completion = try await apiService.getCompletion(prompt: prompt)
//                            chatCompletion = completion
//                        } catch APIService.APIErrors.fetchError {
//                            errorMessage = "Error fething data, try again..."
//                        } catch APIService.APIErrors.decodeError {
//                            errorMessage = "Error decoding data, try again..."
//                        } catch {
//                            errorMessage = "An unknown error occured, try again..."
//                        }
//                        isLoading = false // Reset loading status
//                    }
//                }.buttonStyle(.borderedProminent)
//
//                if isLoading {
//                    ProgressView()
//                }
//
//                if let completion = chatCompletion {
//                    NavigationLink("Your response is ready! Click to view", destination: PromptResult(text: completion.choices[0].message.content))
//                }
//
//                if let error = errorMessage {
//                    Text(error).foregroundColor(.red)
//                }
//            }.padding()
//        }
//    }
//}
//
//struct UserInput_Previews: PreviewProvider {
//    static var previews: some View {
//        UserInput()
//    }
//}
