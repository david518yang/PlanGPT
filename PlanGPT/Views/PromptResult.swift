//
//  PromptResult.swift
//  PlanGPT
//
//  Created by Lucian Prinz on 4/25/23.
//

import SwiftUI

struct PromptResult: View {
    var text: String = ""
    
    var body: some View {
        Text(text)
    }
}

struct PromptResult_Previews: PreviewProvider {
    static var previews: some View {
        PromptResult(text: "Test")
    }
}
