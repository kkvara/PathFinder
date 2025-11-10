// MARK: Schermata Dipartimenti Federico II (versione finale con #102037)
import SwiftUI

extension Color {
    /// Inizializza un colore da stringa esadecimale (es. "#102037")
    init(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexString.hasPrefix("#") { hexString.removeFirst() }

        var int: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&int)

        let r = Double((int >> 16) & 0xFF) / 255.0
        let g = Double((int >> 8) & 0xFF) / 255.0
        let b = Double(int & 0xFF) / 255.0

        self.init(red: r, green: g, blue: b)
    }
}

struct DepartmentsView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // MARK: - Sfondo principale (#102037)
                
                Color(hex: "#102037")
                    .ignoresSafeArea()

                VStack(spacing: 40) {
                    // ---------- TITOLO ----------
                    VStack(spacing: 12) {
                        Text("FEDERICO II")
                            .font(.system(size: 36, weight: .heavy))
                            .foregroundColor(.white)
                            

                        Text("DEPARTMENTS")
                            .font(.system(size: 26, weight: .medium))
                            .foregroundColor(.white.opacity(0.9))
                            .padding(.bottom, 40)
                    }
                    .padding(.top, 60)
                    

                 

                    // ---------- GRIGLIA DIPARTIMENTI ----------
                    let columns = [
                        GridItem(.flexible(minimum: 150), spacing: 20),
                        GridItem(.flexible(minimum: 150), spacing: 20)
                    ]

                    LazyVGrid(columns: columns, spacing: 40) {
                        departmentButton(icon: "building.2", title: "Architecture")
                        departmentButton(icon: "cpu", title: "Engineering")
                        departmentButton(icon: "building.columns", title: "Law school")
                        departmentButton(icon: "syringe", title: "Medicine")
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom, 30)

                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }
    }

    // MARK: - COMPONENTE: Pulsante Dipartimento
    private func departmentButton(icon: String, title: String) -> some View {
        Button(action: {
            print("Hai cliccato su \(title)")
        }) {
            VStack(spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.15))
                        .frame(width: 100, height: 100)

                    Image(systemName: icon)
                        .font(.system(size: 38))
                        .foregroundColor(.white)
                }

                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(width: 120)
            }
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    DepartmentsView()
}
