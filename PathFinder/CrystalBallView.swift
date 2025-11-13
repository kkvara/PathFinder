//
// Single file containing all views (Menu, Quiz, Results) for the orientation flow.
// This view assumes it is pushed/presented by another view (HomeWGameView) and uses
// the @Environment(\.dismiss) to return to the parent when the quiz is complete.
//
import SwiftUI
import Foundation
import Combine
// MARK: - Reusable CircleButton Component

struct CircleButton: View {
    let systemName: String
    var action: (() -> Void)? = nil
    
    var body: some View {
        Button(action: {
            action?()
        }) {
            Image(systemName: systemName)
                .font(.title2)
                .foregroundColor(AppTheme.primaryColor)
                .frame(width: 44, height: 44)
                .background(
                    Circle()
                        .fill(AppTheme.darkCardColor)
                        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 3)
                )
        }
        .buttonStyle(PlainButtonStyle())
    }
}



// MARK: - Data Models

/// Defines the four career categories.
enum Career: String, CaseIterable, Identifiable {
    case engineering = "Engineering"
    case architecture = "Architecture"
    case medicine = "Medicine"
    case law = "Law School"

    var id: String { rawValue }
}

typealias ScoreDelta = [Career: Int]

struct Question: Identifiable {
    let id = UUID()
    let text: String
    let scoreIfYes: ScoreDelta
    let scoreIfNo: ScoreDelta
}

// MARK: - Question Array (In English)

let quizQuestions: [Question] = [
    Question(
        text: "Are you more interested in theoretical subjects than practical application?",
        scoreIfYes: [.engineering: 3, .law: 2, .architecture: -1, .medicine: 0],
        scoreIfNo: [.architecture: 3, .medicine: 2, .engineering: -1, .law: 0]
    ),
    Question(
        text: "Do you prefer working in a team rather than alone?",
        scoreIfYes: [.medicine: 3, .architecture: 2, .engineering: 1, .law: 0],
        scoreIfNo: [.engineering: 2, .law: 3, .medicine: -1, .architecture: -1]
    ),
    Question(
        text: "Do you find satisfaction in solving complex problems or in finding solutions based on ethical/legal principles?",
        scoreIfYes: [.engineering: 4, .architecture: 2, .law: 0, .medicine: 1],
        scoreIfNo: [.law: 3, .medicine: 2, .engineering: -2, .architecture: 0]
    ),
    Question(
        text: "Are you comfortable making quick decisions in high-stress and uncertain situations?",
        scoreIfYes: [.medicine: 4, .law: 2, .engineering: 1, .architecture: 0],
        scoreIfNo: [.engineering: 2, .architecture: 3, .medicine: -2, .law: -1]
    ),
    Question(
        text: "Are attention to detail and precision more important to you than the big picture and creativity?",
        scoreIfYes: [.law: 3, .engineering: 2, .medicine: 1, .architecture: -2],
        scoreIfNo: [.architecture: 4, .medicine: 1, .engineering: 0, .law: -1]
    ),
    Question(
        text: "Are you drawn to the possibility of working directly with people and assisting them with their well-being?",
        scoreIfYes: [.medicine: 4, .law: 3, .architecture: 1, .engineering: -2],
        scoreIfNo: [.engineering: 3, .architecture: 2, .law: -1, .medicine: -3]
    ),
    Question(
        text: "Do you enjoy drawing, modeling, or creating visual representations of ideas and projects?",
        scoreIfYes: [.architecture: 4, .engineering: 1, .medicine: 0, .law: -2],
        scoreIfNo: [.law: 3, .engineering: 2, .medicine: 1, .architecture: -1]
    ),
    Question(
        text: "Does the idea of spending a lot of time reading and interpreting complex texts (like codes or regulations) fascinate you?",
        scoreIfYes: [.law: 4, .engineering: 1, .medicine: 0, .architecture: -1],
        scoreIfNo: [.architecture: 2, .engineering: 3, .medicine: 2, .law: -2]
    ),
    Question(
        text: "Are you skilled at analyzing numerical data, formulas, and complex systems to predict outcomes?",
        scoreIfYes: [.engineering: 4, .medicine: 1, .architecture: 1, .law: 0],
        scoreIfNo: [.law: 2, .medicine: 2, .architecture: 1, .engineering: -3]
    ),
    Question(
        text: "When you encounter a problem, is your first instinct to dismantle it and understand how its internal mechanics work?",
        scoreIfYes: [.engineering: 3, .medicine: 2, .architecture: 1, .law: 0],
        scoreIfNo: [.law: 2, .medicine: 1, .architecture: 3, .engineering: -1]
    )
]

// MARK: - Career tracking model

struct CareerStatus: Identifiable {
    let id = UUID()
    let career: Career
    var played: Bool
}

// MARK: - Main Container View (CrystalBallView)

enum ViewFlow {
    case menu
    case quiz
    case results(Career, [Career: Int])
    
}

struct CrystalBallView: View {
    @State private var currentFlow: ViewFlow = .menu
    
        
    // Stato per tracciare 'played' per ogni categoria
    @State private var careersStatus: [CareerStatus] = Career.allCases.map { CareerStatus(career: $0, played: false) }
    
    private func updatePlayedStatus(winner: Career) {
        for index in careersStatus.indices {
            careersStatus[index].played = (careersStatus[index].career == winner)
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                AppTheme.backgroundGradient
                    .ignoresSafeArea()

                VStack {
                    switch currentFlow {
                    case .menu:
                        MenuContentView(onStartQuiz: {
                            withAnimation { currentFlow = .quiz }
                        })
                    case .quiz:
                        QuestionsView(
                                questions: quizQuestions,
                                onQuizComplete: { winningCareer, finalScores in
                                    updatePlayedStatus(winner: winningCareer)
                                    
                                    // 👇 Salva il risultato in modo persistente
                                    QuizResultManager.shared.saveResult(winningCareer)
                                    
                                    withAnimation {
                                        currentFlow = .results(winningCareer, finalScores)
                                    }
                                },
                            onGoBackToMenu: {
                                withAnimation { currentFlow = .menu }
                            }
                        )
                    case .results(let career, let scores):
                        ResultsView(
                            winningCareer: career,
                            finalScores: scores,
                            
                        )
                    }
                }
            }
            
        }
    }
}



// MARK: - Sub-View 1: Initial Menu

struct MenuContentView: View {
    let onStartQuiz: () -> Void

    var body: some View {
        VStack {
            // Placeholder for the Top Bar (Assuming CircleButton is defined externally)
            HStack {
                CircleButton(systemName: "chevron.left").opacity(0.0)
                Spacer()
                CircleButton(systemName: "star").opacity(0.0)
            }
            .padding(.horizontal, 20)
            .padding(.top, 18)
            .frame(height: 70)

            VStack(spacing: 30) {
                
                // Title
                Text("Welcome future applicant!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(AppTheme.primaryColor)
                    .multilineTextAlignment(.center)
                    .padding(.top, 50)
                
                // Descriptive Card
                VStack(spacing: 15) {
                    Text("In this section, the crystal ball will help you find your right path through 10 questions about your tastes and personality.")
                        .font(.body)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)

                    Text("Press on the icon to get started!")
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                .foregroundColor(AppTheme.primaryColor)
                .padding(25)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(AppTheme.darkCardColor)
                        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                )
                .padding(.horizontal, 20)

                Spacer()

                // Crystal Ball Button
                Button(action: onStartQuiz) {
                    Image("Crystal_Ball_white")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .padding(30)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(AppTheme.darkCardColor)
                                .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 5)
                        )
                }

                Spacer()
            }
        }
    }
}

// MARK: - Sub-View 2: Quiz (QuestionsView)

struct QuestionsView: View {
    let questions: [Question]
    let onQuizComplete: (Career, [Career: Int]) -> Void
    let onGoBackToMenu: () -> Void

    @State private var currentQuestionIndex: Int = 0
    @State private var responses: [UUID: Bool] = [:]
    @State private var selectedAnswer: Bool? = nil

    var currentQuestion: Question {
        questions[currentQuestionIndex]
    }

    var progressValue: Double {
        Double(currentQuestionIndex + 1) / Double(questions.count)
    }

    private func calculateResults() -> (Career, [Career: Int]) {
        var finalScores: [Career: Int] = [
            .engineering: 0, .architecture: 0, .medicine: 0, .law: 0
        ]

        for question in questions {
            if let answer = responses[question.id] {
                let scores = answer ? question.scoreIfYes : question.scoreIfNo
                for (career, score) in scores {
                    finalScores[career] = (finalScores[career] ?? 0) + score
                }
            }
        }

        let winningCareer = finalScores.max { a, b in a.value < b.value }?.key ?? .engineering

        return (winningCareer, finalScores)
    }

    private func advanceQuestion() {
        guard let answer = selectedAnswer else { return }
        responses[currentQuestion.id] = answer

        if currentQuestionIndex == questions.count - 1 {
            let (winner, scores) = calculateResults()
            onQuizComplete(winner, scores)
        } else {
            withAnimation(.easeInOut(duration: 0.3)) {
                currentQuestionIndex += 1
            }
            selectedAnswer = responses[currentQuestion.id]
        }
    }

    private func goBack() {
        if currentQuestionIndex > 0 {
            withAnimation(.easeInOut(duration: 0.3)) {
                currentQuestionIndex -= 1
            }
            selectedAnswer = responses[currentQuestion.id]
        } else {
            onGoBackToMenu()
        }
    }

    var body: some View {
        VStack {
            // Header and Progress Bar
            VStack {

                
                
                // Question Counter (In English)
                HStack {
                    Text("\(currentQuestionIndex + 1) of \(questions.count)")
                        .font(.callout)
                        .padding(.top, 10)
                        .foregroundColor(AppTheme.primaryColor)
                    Spacer()
                }
                .padding(.top, 10)
                .padding(.horizontal, 25)
                .padding(.bottom, 10)

                // Progress Bar
                ProgressView(value: progressValue)
                    .progressViewStyle(LinearProgressViewStyle(tint: AppTheme.primaryColor))
                    .scaleEffect(x: 1, y: 2.5, anchor: .center)
                    .padding(.horizontal, 25)
                    .padding(.bottom, 30)
            }
            .padding(.top, 20)


            // Question Text
            Text(currentQuestion.text)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(AppTheme.primaryColor)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .frame(maxHeight: .infinity)

            // Answer Buttons (Yes/No)
            HStack(spacing: 20) {
                AnswerButtonWithSelection(
                    title: "Yes",
                    isSelected: selectedAnswer == true,
                    action: { selectedAnswer = true }
                )

                AnswerButtonWithSelection(
                    title: "No",
                    isSelected: selectedAnswer == false,
                    action: { selectedAnswer = false }
                )
            }
            .padding(.horizontal, 25)

            // Crystal Ball Button (Confirm)
            Button(action: advanceQuestion) {
                Image("Crystal_Ball_white")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .opacity(selectedAnswer != nil ? 1.0 : 0.4)
                    .animation(.easeInOut, value: selectedAnswer)
                    .padding(30)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(AppTheme.darkCardColor)
                            .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 5)
                    )
            }
            .disabled(selectedAnswer == nil)
            .padding(.vertical, 30)

            Spacer()
        }
    }
}

// MARK: - Answer Button Component

struct AnswerButtonWithSelection: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(AppTheme.primaryColor)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60)
                .padding(.vertical, 15)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(AppTheme.darkCardColor)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(isSelected ? AppTheme.primaryColor : Color.clear, lineWidth: 3)
                        )
                        .shadow(color: .black.opacity(0.5), radius: 8, x: 0, y: 4)
                )
        }
    }
}

// MARK: - Sub-View 3: Results (ResultsView)

struct ResultsView: View {
    let winningCareer: Career
    let finalScores: [Career: Int]

    @EnvironmentObject var gameState: GameState
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            // Header con placeholder
            HStack {
                CircleButton(systemName: "chevron.left").opacity(0.0)
                Spacer()
                CircleButton(systemName: "star").opacity(0.0)
            }
            .padding(.horizontal, 20)
            .padding(.top, 18)
            .frame(height: 70)

            VStack(spacing: 40) {
                Spacer()

                Text("Your Ideal Path")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(AppTheme.primaryColor)

                VStack(spacing: 10) {
                    Text("Based on your answers, the Crystal Ball reveals a strong affinity with:")
                        .font(.headline)
                        .foregroundColor(AppTheme.primaryColor.opacity(0.8))
                        .padding(.bottom, 10)

                    Text(winningCareer.rawValue)
                        .font(.system(size: 34, weight: .heavy, design: .serif))
                        .foregroundColor(AppTheme.primaryColor)
                        .padding(20)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(AppTheme.darkCardColor.opacity(0.9))
                                .shadow(color: AppTheme.primaryColor.opacity(0.4), radius: 15)
                        )

                    // Visualizza punteggi dettagliati per career
                    VStack(alignment: .leading, spacing: 5) {
                        Divider().background(AppTheme.primaryColor.opacity(0.4))
                        Text("Detailed Scores (Max: \(finalScores.values.max() ?? 0))")
                            .font(.caption)
                            .foregroundColor(AppTheme.primaryColor.opacity(0.7))

                        ForEach(Career.allCases) { career in
                            HStack {
                                Text("\(career.rawValue):")
                                Spacer()
                                Text("\(finalScores[career] ?? 0) points")
                                    .fontWeight(.bold)
                            }
                        }
                    }
                    .padding(.top, 20)
                    .font(.subheadline)
                    .foregroundColor(AppTheme.primaryColor)
                    .padding(.horizontal, 20)
                }
                .padding(30)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(AppTheme.darkCardColor)
                        .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 5)
                )
                .padding(.horizontal, 20)

                Spacer()

                // Bottone ritorno a home che aggiorna lo stato e setta la categoria played
                Button(action: {
                    // Aggiorna stato della categoria giocata in PathModel
                    PathModel.setCategoryPlayed(categories: &categoriesData, categoryName: winningCareer.rawValue)

                    // Imposta stato globale gioco fatto
                    gameState.hasPlayedGame = true

                    // Torna indietro alla vista precedente (ContainerView)
                    dismiss()
                }) {
                    Text("Return to Home")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(AppTheme.primaryColor)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(AppTheme.darkCardColor)
                                .shadow(color: .black.opacity(0.5), radius: 8, x: 0, y: 4)
                        )
                }
                .padding(.horizontal, 25)
                .padding(.bottom, 100)
            }
        }
    }
}


// MARK: - Preview Provider (Mock)

#Preview {
    // Mock Container
    struct PreviewContainer: View {
        @State private var currentFlow: ViewFlow = .menu
        var body: some View {
            CrystalBallView()
                .preferredColorScheme(.dark)
        }
    }
    return PreviewContainer()
}
