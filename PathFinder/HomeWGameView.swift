// MARK: Home screen when the user has run the game
import Foundation
import SwiftUI

struct HomeWGameView: View {
    // MARK: - ViewModel dei percorsi (uso dati da struct PathModel)

    @State private var showFullLeaderboard = false

    var sortedPaths: [Path] {
        pathsData.sorted { lhs, rhs in
            if lhs.played == rhs.played {
                return lhs.name < rhs.name
            }
            return lhs.played && !rhs.played
        }
    }

    // Top 3 del leaderboard (per visualizzazione iniziale)
    var top3LeaderboardEntries: [(String, String, String)] = [
        ("1", "Medicina", "95% feedback positivi"),
        ("2", "Ingegneria Aerospaziale", "92% feedback positivi"),
        ("3", "Informatica", "89% feedback positivi")
    ]

    // Lista completa per espansione
    var fullLeaderboardEntries: [(String, String, String)] = [
        ("1", "Medicina", "95% feedback positivi"),
        ("2", "Ingegneria Aerospaziale", "92% feedback positivi"),
        ("3", "Informatica", "89% feedback positivi"),
        ("4", "Giurisprudenza", "85% feedback positivi"),
        ("5", "Economia", "82% feedback positivi"),
        ("6", "Architettura", "80% feedback positivi"),
        ("7", "Psicologia", "78% feedback positivi"),
        ("8", "Biologia", "75% feedback positivi")
    ]

    var body: some View {
        TabView {
            // MARK: --- Home Tab ---
            NavigationStack {
                ZStack {
                    AppTheme.backgroundGradient
                        .ignoresSafeArea()

                    ScrollView {
                        VStack(spacing: 20) {
                            // Header con bottone destra immagine personalizzata
                            HStack(alignment: .top) {
                                Spacer()
                                Spacer()
                                Button(action: { }) {
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
                            }
                            .padding(.horizontal)
                            .padding(.top, 20)

                            // Titolo sopra la scrollView dei percorsi
                            Text("Recommended Paths For You")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            // Scroll orizzontale percorsi
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 20) {
                                    ForEach(sortedPaths) { path in
                                        Button(action: {
                                            print("Hai cliccato su \(path.name)")
                                        }) {
                                            ZStack(alignment: .bottomLeading) {
                                                Rectangle()
                                                    .fill(Color.blue.opacity(0.6))
                                                    .frame(width: 280, height: 160)
                                                    .cornerRadius(15)

                                                LinearGradient(
                                                    gradient: Gradient(colors: [Color.black.opacity(0.6), Color.clear]),
                                                    startPoint: .bottom,
                                                    endPoint: .center)
                                                    .cornerRadius(15)

                                                Text(path.name)
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
                                .padding(.top, 30)
                            }

                            // Pulsante List of Dipartimento grande senza sfondo pieno
                            Button(action: {
                                print("Tasto 'List of Dipartiments' premuto")
                            }) {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("List of Dipartiments")
                                        .font(.system(size: 28, weight: .heavy, design: .rounded))
                                        .foregroundColor(.white)
                                    Text("Esplora tutti i dipartimenti disponibili e scopri il percorso giusto per te")
                                        .font(.system(size: 16, weight: .regular, design: .rounded))
                                        .foregroundColor(.white.opacity(0.7))
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.white.opacity(0.7), lineWidth: 2)
                                )
                                .padding(.horizontal)
                            }

                            // MARK: Classifica Top 3 (grande) con possibilità di espansione
                            VStack(alignment: .leading, spacing: 14) {
                                Text("Classifica dei Percorsi")
                                    .font(.title2)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.white)
                                    .padding(.bottom, 8)

                                // Mostra solo top 3 o tutta la lista a seconda dello stato
                                ForEach(showFullLeaderboard ? fullLeaderboardEntries : top3LeaderboardEntries, id: \.0) { entry in
                                    HStack(spacing: 8) {
                                        // Icona numerica dentro cerchio azzurro
                                        ZStack {
                                            Circle()
                                                .fill(Color.blue.opacity(0.8))
                                                .frame(width: 28, height: 28)
                                            Text(entry.0)
                                                .font(.subheadline)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                        }
                                        // Titolo percorso
                                        Text(entry.1)
                                            .foregroundColor(.white)
                                            .font(.system(.body, design: .rounded))
                                            .bold()
                                        Spacer()
                                        // Percentuale feedback
                                        Text(entry.2)
                                            .foregroundColor(.white.opacity(0.8))
                                            .font(.system(.body, design: .rounded))
                                    }
                                    .padding(.vertical, 4)
                                }

                                // Pulsante per espandere o ridurre la classifica
                                Button(action: {
                                    withAnimation {
                                        showFullLeaderboard.toggle()
                                    }
                                }) {
                                    Text(showFullLeaderboard ? "Mostra meno" : "Mostra tutta la classifica")
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
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }

            // MARK: --- News Tab ---
            Text("News content here")
                .tabItem {
                    Image(systemName: "newspaper.fill")
                    Text("News")
                }

            // MARK: --- Likes Tab ---
            Text("Likes content here")
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Likes")
                }

            // MARK: --- Search Tab ---
            Text("Search content here")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
        }
    }
}

#Preview {
    HomeWGameView()
}
