// MARK: Home screen when the user has run the game
import Foundation
import SwiftUI
//prova
struct HomeWGame: View {
    // MARK: - ViewModel dei percorsi (lettura JSON)
    @StateObject private var pathData = PathDataManager() // Istanza osservabile che carica i percorsi dal file paths.json
    
    var body: some View {
        NavigationStack { // Serve per permettere la navigazione verso altre schermate (es. dettaglio percorso)
            ZStack { // ZStack per mettere il background sotto a tutto
                // Background gradiente richiamato da AppTheme
                AppTheme.backgroundGradient
                    .ignoresSafeArea() // Copre tutto lo schermo, anche notch e barre
                
                //MARK: ---------- HEADER----------
                VStack { // VStack per disporre gli elementi verticalmente
                          // Serve per poter mettere il contenuto in alto con uno Spacer() sotto
                    HStack(alignment: .top) { // allineamento dello stack orizzontale in alto
                        
                        // Bottone a sinistra (Mondo)
                        Button(action: {
                            // Ancora da mettere la pagina che aprirà
                        }) {
                            Image(systemName: "globe")
                                .foregroundColor(.white) // icona bianca
                                .padding() // Aggiunge un margine interno (spazio attorno all’immagine)
                                .background(
                                    Circle()
                                        .fill(Color.white.opacity(0.15)) // sfondo circolare grigio chiaro semi-trasparente
                                )
                        }

                        Spacer() // Spinge il testo centrale verso destra

                        // Testo “Welcome”
                        Text("Welcome")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white) // testo bianco per contrastare lo sfondo scuro

                        Spacer() // Spinge il testo centrale verso sinistra (simmetria)

                        // Bottone a destra (Crystal Ball)
                        Button(action: {
                            // Ancora da mettere la pagina che aprirà
                        }) {
                            Image(systemName: "sparkles") // Crystal ball da mettere nei assets
                                .foregroundColor(.white) // icona bianca
                                .padding() // margine interno per dare respiro all’icona
                                .background(
                                    Circle()
                                        .fill(Color.white.opacity(0.15)) // sfondo circolare grigio chiaro semi-trasparente
                                )
                        }
                    }
                    .padding(.horizontal) // aggiunge spazio orizzontale ai bordi sinistro e destro riferito all'HStack
                    .padding(.top, 20)    // distanza dal bordo superiore riferito all'HStack
                    
                    //MARK: ---------- SEZIONE PERCORSI ----------
                    ScrollView (.horizontal) {
                        VStack(spacing: 20) {
                            ForEach(pathData.paths) { path in
                                // Ogni card è un image button cliccabile che porta alla schermata del percorso
                                Button(action: {
                                    print("Hai cliccato su \(path.title)")
                                    // Qui  metteremo la navigazione verso la pagina del percorso
                                }) {
                                    ZStack(alignment: .bottomLeading) { // Sovrappone testo sopra l'immagine
                                        Image(path.imageName)
                                            .resizable()
                                            .scaledToFill() // riempie tutta la card
                                            .frame(height: 160)
                                            .clipped()
                                        
                                        // Overlay in basso: titolo e leggera sfumatura
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color.black.opacity(0.6), Color.clear]),
                                            startPoint: .bottom,
                                            endPoint: .center
                                        )
                                        .cornerRadius(15)
                                        
                                        Text(path.title)
                                            .font(.headline)
                                            .bold()
                                            .foregroundColor(.white)
                                            .padding()
                                    }
                                    .frame(height: 160)
                                    .cornerRadius(15)
                                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                                    .padding(.horizontal)
                                }
                            }
                        }
                        .padding(.top, 30)
                    }
                    // Fine ScrollView
                    
                    Spacer() // Spinge tutto l’HStack verso l’alto dello schermo
                }
            }
        }
    }
}
//prova commit
#Preview {
    HomeWGame()
}
