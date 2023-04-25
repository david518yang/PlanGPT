//
//  GPT3Response.swift
//  PlanGPT
//
//  Created by Lucian Prinz on 4/24/23.
//

import Foundation

struct ChatCompletion: Codable {
    let choices: [Choice]

    struct Choice: Codable {
        let message: Message
    }

    struct Message: Codable {
        let content: String
    }
}
