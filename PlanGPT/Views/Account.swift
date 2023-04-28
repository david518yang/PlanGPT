//
//  Account.swift
//  PlanGPT
//
//  Created by Lucian Prinz on 4/26/23.
//

import SwiftUI

struct Account: View {    
    var body: some View {
        NavigationView {
            VStack {
                if let userData = UserDefaults.standard.data(forKey: "currentUser"),
                   let user = try? JSONDecoder().decode(User.self, from: userData) {
                    Text(user.displayName ?? "No display name found")
                    Text(user.email ?? "No email found")
                }
                Button(action: FirebaseAuth.shared.signOut) {
                    Text("Sign Out")
                }
            }
            .navigationBarTitle("Account", displayMode: .inline)
        }
    }
}

struct Account_Previews: PreviewProvider {
    static var previews: some View {
        Account()
    }
}
