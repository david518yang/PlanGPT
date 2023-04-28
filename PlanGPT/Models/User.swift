//
//  User.swift
//  PlanGPT
//
//  Created by Lucian Prinz on 4/27/23.
//

import Foundation

struct User: Codable {
    let uid: String
    let email: String?
    let displayName: String?
}
