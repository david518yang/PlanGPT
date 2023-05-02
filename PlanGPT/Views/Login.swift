//
//  Login.swift
//  PlanGPT
//
//  Created by Lucian Prinz on 4/26/23.
//

import SwiftUI
import FirebaseAuth
import GoogleSignIn
import Firebase

struct Login: View {
    var body: some View {
        ZStack {
            Color.black
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [.white, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width:1000,height:400)
                .rotationEffect(.degrees(135))
                .offset(y:-350)
            VStack() {
                Spacer()
                Spacer()
                Text("Welcome to PlanGPT!")
                    .foregroundColor(.white)
                    .font(.system(size:30,weight:.bold,design:.rounded))
                    .offset(x:-35,y:-200)
                Spacer()
                Text("Sign in with Google")
                    .foregroundColor(.white)
                GoogleSignInButton {
                    FirebaseAuth.shared.signInWithGoogle(presenting: getRootViewController()) { error in
                        print("Error: \(String(describing: error))")
                    }
                }
                Spacer()
            }
        }
        .ignoresSafeArea()
        
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
