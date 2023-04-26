//
//  OpenAI API.swift
//  PlanGPT
//
//  Created by Lucian Prinz on 4/24/23.
//

import Foundation

class APIService: ObservableObject {
    enum APIErrors: Error {
        case fetchError
        case decodeError
        case parseError
    }
    
    static let shared = APIService()
    private let apiUrl = "https://api.openai.com/v1/chat/completions"
    private let apiKey = "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"
    
    func getCompletion(prompt: String) async throws -> [Day] {
        guard let url = URL(string: apiUrl) else {
            throw APIErrors.fetchError
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let parameters: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [
                [
                    "role": "user",
                    "content": "\(prompt)"
                ]
            ],
            "temperature": 0
        ]
        
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            throw APIErrors.fetchError
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw APIErrors.fetchError
        }
        
        let decodedCompletion = try JSONDecoder().decode(ChatCompletion.self, from: data)
        let content = decodedCompletion.choices[0].message.content
        print(content)
        let jsonData = content.data(using: .utf8)!
        do {
            let days: [Day] = try JSONDecoder().decode([Day].self, from: jsonData)
            return days
        } catch {
            throw APIErrors.parseError
        }
    }
}
