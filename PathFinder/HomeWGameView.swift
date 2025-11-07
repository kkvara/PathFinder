// MARK: Home screen when the user has run the game
import Foundation
import SwiftUI

struct HomeWGame: View {
    // MARK: - ViewModel dei percorsi (uso dati da struct Path)
    
    var body: some View {
        NavigationStack { // Permette la navigazione verso altre schermate
            ZStack { // Permette di mettere il background dietro tutto
                // Background gradiente definito in AppTheme
                AppTheme.backgroundGradient
                    .ignoresSafeArea() // Copre tutto, anche notch e barre
                
                VStack {
                    // MARK: ---------- HEADER ----------
                    HStack(alignment: .top) {
                        // Bottone a sinistra (Mondo)
                        Button(action: {
                            // Azione futura
                        }) {
                            Image(systemName: "globe")
                                .foregroundColor(.white)
                                .padding()
                                .background(
                                    Circle()
                                        .fill(Color.white.opacity(0.15))
                                )
                        }
                        
                        Spacer() // Spinge il testo verso destra
                        
                        // Titolo centrale
                        Text("Welcome")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                        
                        Spacer() // Spinge il testo centrale verso sinistra
                        
                        // Bottone a destra (Cristallo magico)
                        Button(action: {
                            // Azione futura
                        }) {
                            Image(systemName: "sparkles")
                                .foregroundColor(.white)
                                .padding()
                                .background(
                                    Circle()
                                        .fill(Color.white.opacity(0.15))
                                )
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    // MARK: ---------- SEZIONE PERCORSI ----------
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            // Uso di ForEach con id: \.name se Path non è Identifiable
                            ForEach(pathsData, id: \.name) { path in
                                Button(action: {
                                    print("Hai cliccato su \(path.name)")
                                    // Navigazione futura verso dettaglio percorso
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
                    
                    Spacer() // Spinge tutto verso l’alto
                }
            }
        }
    }
}

#Preview {
    HomeWGame()
}
