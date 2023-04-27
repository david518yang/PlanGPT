//
//  FirebaseAuth.swift
//  PlanGPT
//
//  Created by Lucian Prinz on 4/26/23.
//
// Followed this tutorial for setting up Google Auth with Firebase & SwiftUI https://www.youtube.com/watch?v=M5LiqOBDeGg

import Foundation
import FirebaseAuth
import GoogleSignIn
import Firebase

struct FirebaseAuth {
    static let shared = FirebaseAuth()
    
    private init() { }
    
    func signInWithGoogle(presenting: UIViewController, completion: @escaping(Error?) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: presenting) { result, error in
            guard error == nil else {
                completion(error)
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { result, error in
                
                guard error == nil else {
                    completion(error)
                    return
                }
                
                UserDefaults.standard.set(true, forKey: "signedIn")
            }
        }
    }
    
    func signOut() {
      // 1
      GIDSignIn.sharedInstance.signOut()
      
      do {
        // 2
        try Auth.auth().signOut()
        
        UserDefaults.standard.set(false, forKey: "signedIn")
      } catch {
        print(error.localizedDescription)
      }
    }
}
