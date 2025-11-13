import SwiftUI
import Combine
import Foundation

struct AppTabContainer: View {
    @State private var searchText: String = ""
    @StateObject var gameState = GameState()

    // Filtra solo i corsi, la parte news è completamente rimossa
    var filteredCourses: [Course] {
        guard !searchText.isEmpty else { return [] }
        return categoriesData.flatMap { $0.courses }
            .filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.description.localizedCaseInsensitiveContains(searchText) ||
                $0.department.localizedCaseInsensitiveContains(searchText)
            }
    }

    var body: some View {
        TabView {
            // Tab Home
            Tab("Home", systemImage: "house.fill") {
                if gameState.hasPlayedGame {
                    HomeWGameView()
                        .environmentObject(gameState)
                } else {
                    HomeNGameView()
                        .environmentObject(gameState)
                }
            }

            // Tab Likes
            Tab("Likes", systemImage: "star.fill") {
                FavoritesView()
            }

            // Tab Search ora mostra solo i corsi (niente news)
            Tab(role: .search) {
                NavigationStack {
                    ZStack {
                        AppTheme.backgroundGradient
                            .ignoresSafeArea()

                        List {
                            if !filteredCourses.isEmpty {
                                Section(header: Text("Courses").foregroundColor(.white)) {
                                    ForEach(filteredCourses) { course in
                                        NavigationLink(destination: CourseDetailView(course: course)) {
                                            SearchResultCardView(
                                                title: course.name,
                                                description: course.department,
                                                imageName: course.imageName,
                                                resultType: "Course"
                                            )
                                        }
                                        .listRowBackground(Color.clear)
                                    }
                                }
                            }
                            // Tutto quello che riguardava news è stato rimosso
                        }
                        .listStyle(.insetGrouped)
                        .searchable(text: $searchText, prompt: "Search courses, projects...")
                        .scrollContentBackground(.hidden)
                    }
                }
            }
        }
        .environmentObject(gameState)
    }
}

// Card di ricerca corso (identica, ma senza news)
struct SearchResultCardView: View {
    let title: String
    let description: String
    let imageName: String
    let resultType: String

    var body: some View {
        HStack(spacing: 16) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 80)
                .clipped()
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .lineLimit(1)

                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.9))
                    .lineLimit(2)

                Text(resultType)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
            }

            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.15)) // Sfondo trasparente
        .cornerRadius(20)
    }
}

#Preview {
    AppTabContainer()
}
