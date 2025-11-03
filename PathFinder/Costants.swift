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
}
