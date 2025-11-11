import SwiftUI
import Combine
import Foundation

struct AppTabContainer: View {
    @State private var searchText: String = ""
    @StateObject var gameState = GameState()

    var filteredNews: [News] {
        guard !searchText.isEmpty else { return [] }
        return allNews.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.summary.localizedCaseInsensitiveContains(searchText) ||
            $0.content.localizedCaseInsensitiveContains(searchText)
        }
    }

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
                NewsView()
            }

            Tab("Likes", systemImage: "star.fill") {
                FavoritesView()
            }

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
                                        .listRowBackground(Color.clear) // <--- Qui
                                    }
                                }
                            }

                            if !filteredNews.isEmpty {
                                Section(header: Text("News").foregroundColor(.white)) {
                                    ForEach(filteredNews) { news in
                                        NavigationLink(destination: SingleNewsView(news: news)) {
                                            SearchResultCardView(
                                                title: news.title,
                                                description: news.summary,
                                                imageName: news.imageName,
                                                resultType: "News"
                                            )
                                        }
                                        .listRowBackground(Color.clear) // <--- Qui
                                    }
                                }
                            }

                            // Progetti disabilitati temporaneamente
                            // if !filteredProjects.isEmpty {
                            //     Section(header: Text("Projects").foregroundColor(.white)) {
                            //         ForEach(filteredProjects) { project in
                            //             NavigationLink(destination: ProjectDetailView(project: project)) {
                            //                 SearchResultCardView(
                            //                     title: project.name,
                            //                     description: project.description,
                            //                     imageName: "projectPlaceholder",
                            //                     resultType: "Project"
                            //                 )
                            //             }
                            //             .listRowBackground(Color.clear) // se usi progetti
                            //         }
                            //     }
                            // }
                        }
                        .listStyle(.insetGrouped)
                        .searchable(text: $searchText, prompt: "Search courses, news, projects...")
                        .scrollContentBackground(.hidden)
                    }
                }
            }
        }
        .environmentObject(gameState)
    }
}

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
        .background(Color.white.opacity(0.15))// Background azzurro pieno senza trasparenze
        .cornerRadius(20)
        // Nessuna ombra
    }
}

#Preview {
    AppTabContainer()
}
