import SwiftUI

@available(iOS 26.0, *)
struct CourseDetailView: View {
    let course: Course
    @ObservedObject private var favoritesManager = FavoritesManager.shared
    @State private var isFavoriteLocal: Bool = false
    @State private var showAllReviews: Bool = false

    @State private var newReviewText: String = ""
    @State private var newReviewRating: Int = 3
    @State private var localReviews: [Review] = []
    @State private var showReviewForm: Bool = false

    var displayedReviews: [Review] {
        localReviews + course.reviews
    }

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
                        .padding(.bottom, 50)

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

                    // titolo, università
                    VStack(alignment: .leading, spacing: 8) {
                        Text(course.name)
                            .font(.system(size: 28, weight: .heavy, design: .rounded))
                            .foregroundColor(AppTheme.primaryColor)
                        Text(course.university)
                            .font(.subheadline)
                            .foregroundColor(AppTheme.primaryColor.opacity(0.85))
                    }
                    .padding(.horizontal)

                    Divider()
                        .background(AppTheme.primaryColor.opacity(0.25))
                        .padding(.horizontal)

                    // descrizione con padding bottom per distanza da bottoni
                    Text(course.description)
                        .foregroundColor(AppTheme.primaryColor.opacity(0.95))
                        .padding(.horizontal)
                        .padding(.bottom, 24)

                    // --- SEZIONE BOTTONI ---
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

                    // --- SEZIONE RECENSIONI ---
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Reviews")
                            .font(.headline)
                            .foregroundColor(AppTheme.primaryColor)

                        if displayedReviews.isEmpty {
                            Text("No reviews yet.")
                                .foregroundColor(AppTheme.primaryColor.opacity(0.8))
                        } else {
                            let maxToShow = showAllReviews ? displayedReviews.count : min(3, displayedReviews.count)

                            ForEach(displayedReviews.prefix(maxToShow)) { review in
                                HStack(alignment: .top, spacing: 8) {
                                    Text("“\(review.text)”")
                                        .foregroundColor(AppTheme.primaryColor)
                                    Spacer()
                                    HStack(spacing: 2) {
                                        Text("\(review.rating)")
                                            .foregroundColor(AppTheme.primaryColor)
                                            .font(.caption)
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                            .font(.caption)
                                    }
                                }
                            }

                            if displayedReviews.count > 3 {
                                Button(action: {
                                    withAnimation {
                                        showAllReviews.toggle()
                                    }
                                }) {
                                    Text(showAllReviews ? "Show less" : "Show more")
                                        .font(.callout)
                                        .foregroundColor(.blue.opacity(0.7))
                                        .padding(.top, 8)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 10)

                    // Bottone per mostrare form recensione sotto alle review
                    Button(action: {
                        withAnimation {
                            showReviewForm.toggle()
                        }
                    }) {
                        Text(showReviewForm ? "Cancel Review" : "Add a review")
                            .font(.headline)
                            .foregroundColor(AppTheme.primaryColor)
                            .padding(.horizontal)
                    }

                    // Form recensione nascosto / visibile
                    if showReviewForm {
                        VStack(alignment: .leading, spacing: 8) {
                            TextEditor(text: $newReviewText)
                                .frame(height: 100)
                                .scrollContentBackground(.hidden)
                                .background(RoundedRectangle(cornerRadius: 8).fill(AppTheme.darkCardColor.opacity(0.7)))
                                .foregroundColor(AppTheme.primaryColor)
                                .cornerRadius(8)

                            // Selezione rating con stelle cliccabili
                            HStack(spacing: 4) {
                                Text("Rating:")
                                    .foregroundColor(AppTheme.primaryColor)
                                Spacer()
                                ForEach(1...5, id: \.self) { star in
                                    Image(systemName: star <= newReviewRating ? "star.fill" : "star")
                                        .foregroundColor(star <= newReviewRating ? .yellow : AppTheme.primaryColor)
                                        .font(.title3)
                                        .onTapGesture {
                                            newReviewRating = star
                                        }
                                }
                            }

                            Button(action: {
                                guard !newReviewText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
                                let review = Review(text: newReviewText, rating: newReviewRating)
                                localReviews.insert(review, at: 0)
                                newReviewText = ""
                                newReviewRating = 3
                                showAllReviews = true
                                showReviewForm = false
                            }) {
                                Text("Submit Review")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(RoundedRectangle(cornerRadius: 12).fill(AppTheme.darkCardColor))
                            }
                            .buttonStyle(.plain)
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 12).fill(AppTheme.darkCardColor.opacity(0.9)))
                        .padding(.horizontal)
                    }

                    Spacer(minLength: 20)
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

#Preview {
    let exampleCourse = categoriesData.first!.courses.first!
    CourseDetailView(course: exampleCourse)
}
