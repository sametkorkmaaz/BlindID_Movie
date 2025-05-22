//
//  BlindID_MovieApp.swift
//  BlindID_Movie
//
//  Created by Samet Korkmaz on 22.05.2025.
//

import SwiftUI

@main
struct BlindID_MovieApp: App {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false

    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

struct RootView: View {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false

    var body: some View {
        Group {
            if isLoggedIn {
                MainTabView()
            } else {
                LoginView()
            }
        }
    }
}
