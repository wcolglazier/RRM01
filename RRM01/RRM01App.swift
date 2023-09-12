//
//  RRM01App.swift
//  RRM01
//
//  Created by william colglazier on 10/08/2023.
//
import SwiftUI
import Firebase
@main
struct RRM01App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
