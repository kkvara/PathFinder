// MARK: Modello che rappresenta un percorso (Path)
struct Path: Identifiable, Codable {
    let id: Int               // Identificatore univoco (id)
    let title: String         // Titolo del percorso (tipo "medicina")
    let imageName: String     // Nome dell'immagine negli Assets
    let order: Int            // Valore per determinare l'ordine di visualizzazione
    let summary: String       //  descrizione del percorso 
}
