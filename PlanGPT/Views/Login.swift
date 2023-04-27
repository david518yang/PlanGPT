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
        VStack {
            GoogleSignInButton {
                FirebaseAuth.shared.signInWithGoogle(presenting: getRootViewController()) { error in
                    print("Error: \(String(describing: error))")
                }
            }
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
