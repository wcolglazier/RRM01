
//
//  RootView.swift
//  firebase1
//
//  Created by william colglazier on 04/08/2023.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignInView: Bool = false
    // Removed the unused HomeView state variable

    var body: some View {
        ZStack {
            NavigationStack {
                Home()
            }
        }
        .onAppear {
            // Ensure that any error from getAuthenticatedUser is either logged or handled appropriately.
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack {
                AuthenicationView(showSignInView: $showSignInView)
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
