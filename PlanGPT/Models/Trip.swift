//
//  Trip.swift
//  PlanGPT
//
//  Created by David Yang on 4/27/23.
//

import Foundation

struct Trip: Codable, Hashable, Identifiable {
    let id: String
    let title: String
    let days: [Day]
}
