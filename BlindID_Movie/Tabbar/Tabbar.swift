//
//  Tabbar.swift
//  BlindID_Movie
//
//  Created by Samet Korkmaz on 22.05.2025.
//

import SwiftUI

struct MainTabView: View {
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.darkBG
        appearance.shadowImage = UIImage()
        appearance.shadowColor = .blueB10

        UITabBar.appearance().unselectedItemTintColor = UIColor(.grayG30)
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image("homeIcon")
                        .renderingMode(.template)
                    Text("Home")
                }

            FavoritesView()
                .tabItem {
                    Image("heartIcon")
                        .renderingMode(.template)
                    Text("Favorites")
                }

            ProfileView()
                .tabItem {
                    Image("personIcon")
                        .renderingMode(.template)
                    Text("Profile")
                }
        }
        .accentColor(.blueB10)
    }
}

#Preview {
    MainTabView()
}
