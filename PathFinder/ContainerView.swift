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

    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill") {
                HomeWGameView()
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
        // Only visible on the search tab; still fine to keep globally on TabView
        .searchable(text: $searchText, prompt: "Search places or addresses")
    }
}

#Preview {
        // Inject RouteManager so any child views that use @EnvironmentObject RouteManager won’t crash.
        AppTabContainer()
}

/*Text("News content here")
    .tabItem {
        Image(systemName: "newspaper.fill")
        Text("News")
    }

Text("Likes content here")
    .tabItem {
        Image(systemName: "star.fill")
        Text("Likes")
    }

Text("Search content here")
    .tabItem {
        Image(systemName: "magnifyingglass")
        Text("Search")
    }
*/
