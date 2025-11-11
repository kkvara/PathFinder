import SwiftUI

@available(iOS 26.0, *)
struct CourseDetailView: View {
    let course: Course
    @ObservedObject private var favoritesManager = FavoritesManager.shared
    @State private var isFavoriteLocal: Bool = false

    var body: some View {
        ZStack {
            AppTheme.backgroundGradient
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {

                    // top row: bottone stella
                    HStack {
                        Spacer()
                        Button(action: {
                            favoritesManager.toggleFavorite(for: course)
                            isFavoriteLocal = favoritesManager.isFavorite(course)
                        }) {
                            Image(systemName: isFavoriteLocal ? "star.fill" : "star")
                                .font(.system(size: 24))
                                .foregroundColor(isFavoriteLocal ? .yellow : AppTheme.primaryColor)
                                .padding(10)
                        }
                    }
                    .padding(.horizontal)

                    // icona corso centrata
                    Image(systemName: course.iconName)
                        .font(.system(size: 60))
                        .foregroundColor(AppTheme.primaryColor)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 8)

                    // immagine principale (se esiste)
                    if !course.imageName.isEmpty {
                        Image(course.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 220)
                            .clipped()
                            .cornerRadius(14)
                            .shadow(radius: 8)
                            .padding(.horizontal)
                    }

                    // titolo, università, score
                    VStack(alignment: .leading, spacing: 8) {
                        Text(course.name)
                            .font(.system(size: 28, weight: .heavy, design: .rounded))
                            .foregroundColor(AppTheme.primaryColor)
                        Text(course.university)
                            .font(.subheadline)
                            .foregroundColor(AppTheme.primaryColor.opacity(0.85))
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text(String(format: "%.1f", course.score))
                                .foregroundColor(AppTheme.primaryColor)
                        }
                    }
                    .padding(.horizontal)

                    Divider().background(AppTheme.primaryColor.opacity(0.25)).padding(.horizontal)

                    Text(course.description)
                        .foregroundColor(AppTheme.primaryColor.opacity(0.95))
                        .padding(.horizontal)

                    // recensioni
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Reviews")
                            .font(.headline)
                            .foregroundColor(AppTheme.primaryColor)
                        if course.reviews.isEmpty {
                            Text("No reviews yet.")
                                .foregroundColor(AppTheme.primaryColor.opacity(0.8))
                        } else {
                            ForEach(course.reviews) { r in
                                Text("“\(r.text)”")
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 12).fill(AppTheme.darkCardColor.opacity(0.6)))
                                    .foregroundColor(AppTheme.primaryColor)
                            }
                        }
                    }
                    .padding(.horizontal)

                    // --- INIZIO NUOVA SEZIONE BOTTONI ---
                    NavigationLink(destination: LocationsView(course: course)) {
                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                                .font(.system(size: 22))
                                .foregroundColor(AppTheme.primaryColor)
                            Text("Location")
                                .font(.headline)
                                .foregroundColor(AppTheme.primaryColor)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 12).fill(AppTheme.darkCardColor.opacity(0.9)))
                        .shadow(radius: 5)
                        .padding(.horizontal)
                    }

                    NavigationLink(destination: ProjectsView(course: course)) {
                        HStack {
                            Image(systemName: "list.bullet.rectangle")
                                .font(.system(size: 22))
                                .foregroundColor(AppTheme.primaryColor)
                            Text("Projects")
                                .font(.headline)
                                .foregroundColor(AppTheme.primaryColor)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 12).fill(AppTheme.darkCardColor.opacity(0.9)))
                        .shadow(radius: 5)
                        .padding(.horizontal)
                    }
                    // --- FINE NUOVA SEZIONE BOTTONI ---

                    Spacer(minLength: 40)
                }
                .padding(.vertical)
                .onAppear {
                    isFavoriteLocal = favoritesManager.isFavorite(course)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

