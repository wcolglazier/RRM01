//
//  SettingsView.swift
//  firebase1
//
//  Created by william colglazier on 05/08/2023.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    @Binding var showSignInView: Bool
    
    init(showSignInView: Binding<Bool>) {
        self._showSignInView = showSignInView
    }
    
    func logOut() throws {
        try AuthenticationManager.shared.signOut()
        DispatchQueue.main.async {
            self.showSignInView = true
        }
    }
}


struct SettingsView: View {
    @Binding var showSignInView: Bool
    @StateObject private var viewModel: SettingsViewModel
    
    init(showSignInView: Binding<Bool>) {
        self._showSignInView = showSignInView
        self._viewModel = StateObject(wrappedValue: SettingsViewModel(showSignInView: showSignInView))
    }
    
    var body: some View {
        List {
            Button("Log Out") {
                Task {
                    do {
                        try viewModel.logOut()
                    } catch {
                        print(error)
                    }
                }
            }
        }
        .navigationBarTitle("settings")
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            SettingsView(showSignInView: .constant(false))
//        }
//    }
//}
