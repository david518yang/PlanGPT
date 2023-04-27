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
