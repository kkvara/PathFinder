import Foundation
import Combine

final class FavoritesManager: ObservableObject {
    static let shared = FavoritesManager()

    @Published private(set) var favoriteCourseIDs: Set<UUID> = []

    private let key = "favoriteCourses_v1" // usa una key univoca

    private init() {
        loadFavorites()
    }

    func isFavorite(_ course: Course) -> Bool {
        favoriteCourseIDs.contains(course.id)
    }

    func toggleFavorite(for course: Course) {
        if favoriteCourseIDs.contains(course.id) {
            favoriteCourseIDs.remove(course.id)
        } else {
            favoriteCourseIDs.insert(course.id)
        }
        saveFavorites()
    }

    private func saveFavorites() {
        // Salva come array di UUID stringhe
        let ids = favoriteCourseIDs.map { $0.uuidString }
        UserDefaults.standard.set(ids, forKey: key)
    }

    private func loadFavorites() {
        if let saved = UserDefaults.standard.array(forKey: key) as? [String] {
            favoriteCourseIDs = Set(saved.compactMap { UUID(uuidString: $0) })
        } else {
            favoriteCourseIDs = []
        }
    }
}
