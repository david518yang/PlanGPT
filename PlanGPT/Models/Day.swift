//
//  Day.swift
//  PlanGPT
//
//  Created by Lucian Prinz on 4/25/23.
//

import Foundation

struct Day: Codable, Hashable {
    let day: Int?
    let food: String
    let location: String
    let sightseeing: String
    let latitude: Double
    let longitude: Double
}
