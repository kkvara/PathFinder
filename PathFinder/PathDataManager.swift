import Foundation
import Combine

//MARK: Data manager che carica i Path da un file JSON nel bundle.
final class PathDataManager: ObservableObject {
    // Published così la UI si aggiorna automaticamente quando cambia l'array
    //creo un array di path (sarebbe Array<Element>) e la inizializzo vuota
    @Published var paths: [Path] = []
    //init() è il costruttore (initializer) di una classe/struct in modo che la variabile sia pronta subito dopo la creazione
    init() {
        loadPaths() // carica automaticamente all'inizializzazione
    }
    
    //Carica il JSON "paths.json" dal bundle principale, decodifica e ordina per `order`.
    func loadPaths() {
        // Cerca l'URL del file nel bundle
        //guard let è una forma di controllo per gli optional che permette di uscire precocemente dalla funzione se la condizione fallisce. È usato per unwrappare il valore dall'optional in modo sicuro.
        //Bundle.main.url(forResource: "paths", withExtension: "json") cerca un file chiamato paths.json nel bundle principale dell'app e restituisce un URL?
        guard let url = Bundle.main.url(forResource: "paths", withExtension: "json") else {
            print("paths.json non trovato")
            return
        }
        //try e let li uso per la gestione degli errori
        do {
            // Legge i byte del file
            let data = try Data(contentsOf: url)
            // Decodifica il JSON in array di Path
            var decoded = try JSONDecoder().decode([Path].self, from: data)
            // Ordina in base alla proprietà order (valore minore = prima)
            decoded.sort { $0.order < $1.order }
            // Aggiorna la proprietà pubblicata (notifica le view),
            //DispatchQueue.main.async esegue il blocco  sul main thread, in modo asincrono (non blocca il thread corrente).
            DispatchQueue.main.async {
                self.paths = decoded
            }
        } catch {
            // Stampa l'errore per debug
            print("Errore durante il caricamento/decoding di paths.json: \(error)")
        }
    }
    
}

