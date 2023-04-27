//
//  ViewExtensions.swift
//  PlanGPT
//
//  Created by Lucian Prinz on 4/26/23.
//

import Foundation
import SwiftUI

extension View {
    func getRootViewController () -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }

        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        

        return root
    }
}
