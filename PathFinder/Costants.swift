// Qui mettiamo le costanti
import Foundation
import SwiftUI

// MARK: - App Theme Colors & Gradients
struct AppTheme {
    
    // Colori personalizzati
    static let topBlue = Color(red: 35/255, green: 68/255, blue: 103/255)
    static let bottomBlue = Color(red: 16/255, green: 32/255, blue: 55/255)
    
    // Gradiente verticale da topBlue (in alto) a bottomBlue (in basso)
    static let backgroundGradient = LinearGradient(
        gradient: Gradient(colors: [topBlue, bottomBlue]),
        startPoint: .top,
        endPoint: .bottom
    )
    
    // Colore di base per le card/bottoni, derivato dai colori del gradiente
    static let darkCardColor = Color(red: 50/255, green: 80/255, blue: 120/255).opacity(0.7) // Colore scuro per card e bottoni
    
    // Colore primario per il testo e le icone
    static let primaryColor = Color.white
}
