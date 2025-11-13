import Foundation
import SwiftUI

struct HomeWGameView: View {
    @State private var showFullLeaderboard = false

    // Calcola la media dei rating di un corso
    private func averageRating(for course: Course) -> Double {
        guard !course.reviews.isEmpty else { return 0 }
        let totalRating = course.reviews.reduce(0) { $0 + $1.rating }
        return Double(totalRating) / Double(course.reviews.count)
    }

    // Ottiene tutti i corsi da tutte le categorie
    private var allCourses: [Course] {
        categoriesData.flatMap { $0.courses }
    }

    // Leaderboard ordinata per media rating decrescente
    private var leaderboardByRating: [(course: Course, averageRating: Double)] {
        allCourses.map { course in
            (course: course, averageRating: averageRating(for: course))
        }
        .sorted { $0.averageRating > $1.averageRating }
    }

    // Corsie ordinate per played della categoria e nome del corso
    private var sortedCourses: [Course] {
        allCourses.sorted { lhs, rhs in
            // Trova se la categoria è played
            let lhsPlayed = categoriesData.first(where: { $0.courses.contains(where: { $0.id == lhs.id }) })?.played ?? false
            let rhsPlayed = categoriesData.first(where: { $0.courses.contains(where: { $0.id == rhs.id }) })?.played ?? false

            if lhsPlayed == rhsPlayed {
                return lhs.name < rhs.name
            }
            return lhsPlayed && !rhsPlayed
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                AppTheme.backgroundGradient
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {
                        HStack(alignment: .center) {
                            Text("PATHFINDER")
                                .font(.system(size: 34, weight: .heavy))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                                .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 2)

                            Spacer()

                            NavigationLink(destination: CrystalBallView()) {
                                Image("Crystal_Ball_white")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .padding()
                                    .background(
                                        Circle()
                                            .fill(Color.white.opacity(0.15))
                                    )
                            }
                            .padding(.trailing, 24)
                        }
                        .padding(.vertical, 10)

                        Text("Recommended Paths For You")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(sortedCourses) { course in
                                    NavigationLink(destination: CourseDetailView(course: course)) {
                                        ZStack(alignment: .bottomLeading) {
                                            Image(course.imageName)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 280, height: 160)
                                                .cornerRadius(15)
                                                .clipped()

                                            LinearGradient(
                                                gradient: Gradient(colors: [Color.black.opacity(0.6), Color.clear]),
                                                startPoint: .bottom,
                                                endPoint: .center
                                            )
                                            .cornerRadius(15)

                                            Text(course.name)
                                                .font(.headline)
                                                .bold()
                                                .foregroundColor(.white)
                                                .padding()
                                        }
                                        .frame(width: 280, height: 160)
                                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                                        .padding(.horizontal)
                                    }
                                }
                            }
                            .padding(.top)
                            .padding(.horizontal)
                            .padding(.bottom)
                        }

                        NavigationLink(destination: DepartmentsView()) {
                            VStack(alignment: .leading, spacing: 6) {
                                Text("List of Departments")
                                    .font(.system(size: 28, weight: .heavy, design: .rounded))
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white.opacity(0.7), lineWidth: 2)
                            )
                            .padding(.horizontal)
                        }

                        VStack(alignment: .leading, spacing: 14) {
                            Text("Ranking of courses")
                                .font(.title2)
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .padding(.bottom, 8)

                            ForEach(showFullLeaderboard ? leaderboardByRating : Array(leaderboardByRating.prefix(3)), id: \.course.id) { entry in
                                HStack(spacing: 8) {
                                    ZStack {
                                        Circle()
                                            .fill(Color.blue.opacity(0.8))
                                            .frame(width: 28, height: 28)
                                        Text("\(leaderboardByRating.firstIndex(where: { $0.course.id == entry.course.id })! + 1)")
                                            .font(.subheadline)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                    }
                                    NavigationLink(destination: CourseDetailView(course: entry.course)) {
                                        Text(entry.course.name)
                                            .foregroundColor(.white)
                                            .font(.system(.body, design: .rounded))
                                            .bold()
                                    }
                                    Spacer()
                                    Text(String(format: "%.1f average rating", entry.averageRating))
                                        .foregroundColor(.white.opacity(0.8))
                                        .font(.system(.body, design: .rounded))
                                }
                                .padding(.vertical, 4)
                            }

                            Button(action: {
                                withAnimation {
                                    showFullLeaderboard.toggle()
                                }
                            }) {
                                Text(showFullLeaderboard ? "Show less" : "Show more")
                                    .font(.callout)
                                    .foregroundColor(.blue.opacity(0.7))
                                    .padding(.top, 8)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 20)

                        Spacer(minLength: 20)
                    }
                }
            }
        }
    }
}

#Preview {
    HomeWGameView()
}
