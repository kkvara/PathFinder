// Home screen when the user has run the game
import Foundation
import SwiftUI

struct HomeWGame: View {
    var body: some View {
        VStack { // VStack per disporre gli elementi verticalmente
                  // Serve per poter mettere il contenuto in alto con uno Spacer() sotto
            
            HStack(alignment: .top) { // allineamento dello stack orizzontale in alto
                
                // Bottone a sinistra (Mondo)
                Button(action: {
                    // Ancora da mettere la pagina che aprirà
                }) {
                    Image(systemName: "globe")
                        .padding() // Aggiunge un margine interno (spazio attorno all’immagine)
                        .background(Circle().fill(Color.gray.opacity(0.2))) // aggiunge uno sfondo grigio semi-trasparente dietro all’immagine
                        // .position(x:33,y:22) // posizione scritta a mano 
                }

                Spacer() // Spinge il testo centrale verso destra

                // Testo “Welcome”
                Text("Welcome")
                    .font(.title2)
                    .bold()

                Spacer() // Spinge il testo centrale verso sinistra (simmetria)

                // Bottone a destra (Crystal Ball)
                Button(action: {
                    // Ancora da mettere la pagina che aprirà
                }) {
                    Image(systemName: "sparkles") // Crystal ball da mettere nei assets
                        .padding() // margine interno per dare respiro all’icona
                        .background(Circle().fill(Color.gray.opacity(0.2))) // sfondo circolare grigio semi-trasparente
                }
            }
            .padding(.horizontal) // aggiunge spazio orizzontale ai bordi sinistro e destro riferito all'HStack
            .padding(.top, 20)    // distanza dal bordo superiore riferito all'HStack

            Spacer() // Spinge tutto l’HStack verso l’alto dello schermo
        }
    }
}
