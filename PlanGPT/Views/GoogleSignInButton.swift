//
//  GoogleSignInButton.swift
//  PlanGPT
//
//  Created by Lucian Prinz on 4/26/23.
//

import SwiftUI
import GoogleSignIn

struct GoogleSignInButton: View {
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack{
                Circle()
                    .foregroundColor(.white)
                    .shadow(color: .gray, radius: 4, x: 0, y: 2)
                
                Image("google")
                    .resizable()
                    .scaledToFit()
                    .padding(8)
                    .mask(
                        Circle()
                    )
            }
            
        }
        .frame(width: 50, height: 50)
    }
}

struct GoogleSignInButton_Previews: PreviewProvider {
    static var previews: some View {
        GoogleSignInButton(action: {})
    }
}
