
import SwiftUI

// MARK: - Modello Dati per la Domanda
struct Question: Identifiable {
    let id = UUID()
    let text: String
}

// MARK: - Vista Fittizia per il Tab Bar Item
struct TabBarItemView: View {
    let iconName: String
    let title: String

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: iconName)
                .font(.system(size: 16))
            Text(title)
                .font(.caption2)
        }
        .foregroundColor(AppTheme.primaryColor)
    }
}

// MARK: - VISTA INIZIALE
struct OrientationMenuView: View {
    // Lo stato per controllare la navigazione alla schermata delle domande
    @State private var isGameActive = false
    
    // Esempio di 10 domande per l'orientamento
    private let questions: [Question] = [
        Question(text: "Are you more interested in theoretical subjects than practical application?"), // Domanda 1
        Question(text: "Do you prefer working in a team rather than alone?"), // Domanda 2
        Question(text: "Do you enjoy analyzing complex data and statistics?"),
        Question(text: "Are you passionate about humanities, such as literature and history?"),
        Question(text: "Do you like spending time outdoors and with nature?"),
        Question(text: "Are you comfortable with public speaking and presentations?"),
        Question(text: "Do you often look for creative solutions to practical problems?"),
        Question(text: "Is precision and attention to detail important in your activities?"),
        Question(text: "Do you prefer subjects that require manual skills?"),
        Question(text: "Do you feel motivated by competition and challenges?") // Domanda 10
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                // Sfondo con il gradiente definito
                AppTheme.backgroundGradient
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    // MARK: - Testo di Benvenuto
                    Text("Welcome future applicant!")
                        .font(.custom("Palatino", size: 36)) // Utilizza un font che richiami lo stile
                        .fontWeight(.light)
                        .foregroundColor(AppTheme.primaryColor)
                        .multilineTextAlignment(.center)
                        .padding(.top, 40)
                    
                    Spacer().frame(height: 50)
                    
                    // MARK: - Card Esplicativa
                    VStack(spacing: 15) {
                        Text("In this section, the crystal ball will help you find your right path through \(questions.count) questions about your tastes and personality.")
                            .font(.title3)
                            .fontWeight(.regular)
                            .multilineTextAlignment(.center)
                        
                        Text("Press on the icon to get started!")
                            .font(.headline)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                    }
                    .foregroundColor(AppTheme.primaryColor)
                    .padding(30)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(AppTheme.darkCardColor)
                            .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                    )
                    .padding(.horizontal, 30)
                    
                    Spacer().frame(height: 60)
                    
                    // MARK: - Bottone/Icona Sfera di Cristallo
                    // Naviga alla prima domanda (indice 0)
                    NavigationLink(destination: QuestionsView(questions: questions), isActive: $isGameActive) {
                        EmptyView()
                    }
                    .hidden()
                    
                    Button {
                        isGameActive = true
                    } label: {
                        // Sostituisco con una SF Symbol
                        Image(systemName: "globe.central.south.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .padding(30)
                            .background(
                                RoundedRectangle(cornerRadius: 25.0)
                                    .fill(AppTheme.darkCardColor)
                                    .shadow(color: .black.opacity(0.5), radius: 15, x: 0, y: 8)
                            )
                    }
                    
                    Spacer()
                    
                    // MARK: - Tab Bar Fittizia (Riprodotta dagli screenshot)
                    HStack {
                        Spacer()
                        TabBarItemView(iconName: "house.fill", title: "Home")
                        Spacer()
                        TabBarItemView(iconName: "newspaper.fill", title: "News")
                        Spacer()
                        TabBarItemView(iconName: "star.fill", title: "Likes")
                        Spacer()
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .frame(width: 48, height: 48)
                            .background(
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(AppTheme.darkCardColor)
                            )
                        Spacer().frame(width: 10)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(AppTheme.darkCardColor)
                            .frame(maxWidth: .infinity)
                            .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: -5)
                    )
                    .padding(.horizontal, 10)
                }
            }
            .navigationBarHidden(true)
        }
    }
}


// MARK: - VISTA DEL GIOCO DINAMICO
struct QuestionsView: View {
    @Environment(\.dismiss) var dismiss
    
    // Le domande fornite dalla vista precedente
    let questions: [Question]
    
    // Indice per tracciare la domanda corrente (parte da 0)
    @State private var currentQuestionIndex: Int = 0
    
    // Risultati, in un'app reale verrebbe usato un set più complesso
    @State private var responses: [UUID: Bool] = [:]
    
    // La domanda attuale da mostrare
    var currentQuestion: Question {
        questions[currentQuestionIndex]
    }
    
    // Contatore per la UI (es. "1 of 10")
    var questionCounterText: String {
        "\(currentQuestionIndex + 1) of \(questions.count)"
    }
    
    // Valore della barra di progresso (0.0 a 1.0)
    var progressValue: Float {
        Float(currentQuestionIndex + 1) / Float(questions.count)
    }

    private func answerQuestion(isYes: Bool) {
        // Registra la risposta
        responses[currentQuestion.id] = isYes
        
        // Controlla se ci sono altre domande
        if currentQuestionIndex < questions.count - 1 {
            // Avanza alla prossima domanda
            currentQuestionIndex += 1
        } else {
            // Tutte le domande sono state risposte, naviga al risultato (Simulato)
            print("Quiz completato. Risposte: \(responses)")
            // Potresti navigare a una ResultsView qui
            // Ad esempio: dismiss() per tornare alla OrientationMenuView
        }
    }
    
    var body: some View {
        ZStack {
            AppTheme.backgroundGradient
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // MARK: - Header (Back Button + Progress)
                HStack {
                    // Bottone "Back" personalizzato
                    Button {
                        // Se non è la prima domanda, torna indietro, altrimenti esci
                        if currentQuestionIndex > 0 {
                            currentQuestionIndex -= 1
                        } else {
                            dismiss()
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(AppTheme.primaryColor)
                            .frame(width: 48, height: 48)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(AppTheme.darkCardColor)
                            )
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                // Contatore Domande
                HStack {
                    Text(questionCounterText)
                        .font(.headline)
                        .foregroundColor(AppTheme.primaryColor.opacity(0.8))
                    Spacer()
                }
                .padding(.horizontal, 25)
                .padding(.top, 10)
                
                // Barra di Progresso
                ProgressView(value: progressValue)
                    .progressViewStyle(LinearProgressViewStyle(tint: AppTheme.primaryColor))
                    .scaleEffect(x: 1, y: 3, anchor: .center) // Aumenta l'altezza visiva
                    .padding(.horizontal, 25)
                
                Spacer()
                
                // MARK: - Testo della Domanda
                Text(currentQuestion.text)
                    .font(.largeTitle)
                    .fontWeight(.regular)
                    .foregroundColor(AppTheme.primaryColor)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .transition(.opacity) // Aggiungi una transizione per un effetto più fluido
                
                Spacer()
                
                // MARK: - Bottoni Sì / No
                HStack(spacing: 30) {
                    // Bottone "Yes"
                    AnswerButton(text: "Yes") {
                        answerQuestion(isYes: true)
                    }
                    
                    // Bottone "No"
                    AnswerButton(text: "No") {
                        answerQuestion(isYes: false)
                    }
                }
                .padding(.horizontal, 40)
                
                Spacer().frame(height: 50)
                
                // MARK: - Icona Sfera di Cristallo Centrale
                Image(systemName: "globe.central.south.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)
                    .padding(30)
                    .background(
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(AppTheme.darkCardColor)
                            .shadow(color: .black.opacity(0.5), radius: 15, x: 0, y: 8)
                    )
                
                Spacer()
                
                // MARK: - Tab Bar Fittizia (Riprodotta dagli screenshot)
                HStack {
                    Spacer()
                    TabBarItemView(iconName: "house.fill", title: "Home")
                    Spacer()
                    TabBarItemView(iconName: "newspaper.fill", title: "News")
                    Spacer()
                    TabBarItemView(iconName: "star.fill", title: "Likes")
                    Spacer()
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .frame(width: 48, height: 48)
                        .background(
                            RoundedRectangle(cornerRadius: 24)
                                .fill(AppTheme.darkCardColor)
                        )
                    Spacer().frame(width: 10)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(AppTheme.darkCardColor)
                        .frame(maxWidth: .infinity)
                        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: -5)
                )
                .padding(.horizontal, 10)
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Componente Bottone Risposta
struct AnswerButton: View {
    let text: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(AppTheme.primaryColor)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(AppTheme.darkCardColor)
                        .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
                )
        }
    }
}

struct OrientationMenuView_Previews: PreviewProvider {
    static var previews: some View {
        OrientationMenuView()
    }
}
