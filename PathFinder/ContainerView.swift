//
//  ContainerView.swift
//  PathFinder
//
//  Created by AFP Student 6 on 10/11/25.

import SwiftUI
import Foundation
import Combine

@available(iOS 26.0, *)
struct AppTabContainer: View {
    @State private var searchText: String = ""
    @StateObject var gameState = GameState()

    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill") {
                if gameState.hasPlayedGame {
                                    HomeWGameView()
                                        .environmentObject(gameState)
                                } else {
                                    HomeNGameView()
                                        .environmentObject(gameState)
                                }

            }

            Tab("News", systemImage: "newspaper.fill") {
                Text("Teams Screen")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(.systemBackground))
            }

            Tab("Likes", systemImage: "star.fill") {
                Text("Profile Screen")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(.systemBackground))
            }

            Tab(role: .search) {
                NavigationStack {
                    // Drive the search screen from the TabView’s search pill
                }
            }
        }
        .environmentObject(gameState)
    }
      
}

#Preview {
        // Inject RouteManager so any child views that use @EnvironmentObject RouteManager won’t crash.
        AppTabContainer()
}

