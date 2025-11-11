//
//  FavoritesView.swift
//  PathFinder
//
//  Created by AFP Student 8 on 11/11/25.
//

import SwiftUI

struct FavoritesView: View {
    // Istanza singleton che gestisce i preferiti
    @ObservedObject var favoritesManager = FavoritesManager.shared

    // Calcola la lista dei corsi preferiti filtrando quelli in categoriesData in base agli ID salvati
    var favoriteCourses: [Course] {
        categoriesData.flatMap { $0.courses }
            .filter { favoritesManager.favoriteCourseIDs.contains($0.id) }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Titolo pagina
                    Text("Favorites")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.leading, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    // Se non ci sono corsi preferiti mostra messaggio
                    if favoriteCourses.isEmpty {
                        Text("No favorites yet")
                            .foregroundColor(.white.opacity(0.7))
                            .font(.title3)
                            .padding()
                    } else {
                        // Lista verticale di schede preferite
                        VStack(spacing: 15) {
                            ForEach(favoriteCourses) { course in
                                // Ogni scheda è cliccabile e apre la CourseDetailView
                                NavigationLink(destination: CourseDetailView(course: course)) {
                                    FavoriteCourseCardView(course: course)
                                }
                                // Rimuove lo stile di default del bottone per una UI più pulita
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
                .padding(.vertical)
            }
            .background(AppTheme.backgroundGradient) // Sfondo tematico
            .navigationBarTitleDisplayMode(.inline)  // Stile della navbar
        }
    }
}

// Card singola per mostrare anteprima del corso nella lista preferiti
struct FavoriteCourseCardView: View {
    let course: Course

    var body: some View {
        HStack(spacing: 12) {
            // Immagine quadrata del corso
            Image(course.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipped()
                .cornerRadius(10)

            // Nome e descrizione breve
            VStack(alignment: .leading, spacing: 4) {
                Text(course.name)
                    .font(.headline)
                    .foregroundColor(.white)
                    .lineLimit(1)
                Text(course.description)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                    .lineLimit(2)
            }

            Spacer() // Spazio vuoto a destra
        }
        .padding()
        .background(Color.white.opacity(0.15)) // Sfondo semi-trasparente
        .cornerRadius(20)                     // Angoli arrotondati
        .shadow(radius: 6, x: 0, y: 2)       // Ombra leggera
    }
}


#Preview {
    FavoritesView()
}
