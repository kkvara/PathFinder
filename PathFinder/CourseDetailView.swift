import SwiftUI
 
struct CourseDetailView: View {
    var body: some View {
        ZStack {
            // Sfondo gradiente blu → celeste
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.85), Color.cyan.opacity(0.7)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 16.5) {
                // Top bar (back + star)
                HStack {
                    CircleButton(systemName: "chevron.left")
                    Spacer()
                    CircleButton(systemName: "star")
                }
                .padding(.horizontal, 20)
                .padding(.top, 18)
                
                // Logo 2x2 e titolo
                VStack(spacing: 10) {
                    Logo2x2()
                    Text("COMMUNITY DESIGN")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.white)
                        .tracking(1.5)
                }
                .padding(.top, 6)
                
                // Contenuto scrollabile
                ScrollView {
                    VStack(alignment: .leading, spacing: 18) {
                        Text("What is it?")
                            .foregroundColor(Color.white.opacity(0.85))
                            .font(.system(size: 15, weight: .regular))
                        
                        Text("""
Community design is the first and only three-year design program at Federico II University.
""")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .bold))
                            .fixedSize(horizontal: false, vertical: true)
                        
                        Text("""
The course provides the fundamentals of various branches of design, such as Graphic Design, Interior Design, Web Design, UI & UX Design, and Community Design.
""")
                            .foregroundColor(.white.opacity(0.95))
                            .font(.system(size: 15, weight: .regular))
                            .fixedSize(horizontal: false, vertical: true)
                        
                        // Pulsanti grandi arrotondati
                        VStack(spacing: 18) {
                            LargeRoundedButton(title: "Locations", systemName: "mappin.and.ellipse")
                            LargeRoundedButton(title: "Projects", systemName: "doc.on.doc")
                        }
                        .padding(.top, 6)
                        
                        Spacer(minLength: 40)
                    }
                    .padding(.horizontal, 28)
                    .padding(.top, 6)
                    .padding(.bottom, 70) // spazio per barra inferiore
                }
                
            } // VStack principale
            .frame(maxWidth: .infinity)
            
            // Bottom tab bar
            VStack {
                Spacer()
                BottomBar()
            }
            .padding(.bottom, 8)
        } // ZStack
    }
}
 
// MARK: - CircleButton
 
struct CircleButton: View {
    let systemName: String
    var body: some View {
        Button(action: {}) {
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.14))
                    .frame(width: 44, height: 44)
                Image(systemName: systemName)
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .semibold))
            }
        }
    }
}
 
// MARK: - Logo 2x2
 
struct Logo2x2: View {
    var body: some View {
        VStack(spacing: 6) {
            HStack(spacing: 8) {
                LogoItem(systemName: "xmark")
                LogoItem(systemName: "triangle")
            }
            HStack(spacing: 8) {
                LogoItem(systemName: "circle")
                LogoItem(systemName: "square")
            }
        }
        .padding(.bottom, 2)
    }
}
 
struct LogoItem: View {
    let systemName: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.white.opacity(0.0))
                .frame(width: 26, height: 26)
            Image(systemName: systemName)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
        }
    }
}
 
// MARK: - LargeRoundedButton
 
struct LargeRoundedButton: View {
    let title: String
    let systemName: String
    var body: some View {
        Button(action: {}) {
            HStack {
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: systemName)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white.opacity(0.95))
            }
            .padding(.vertical, 18)
            .padding(.horizontal, 20)
            .background(
                RoundedRectangle(cornerRadius: 28)
                    .fill(Color.white.opacity(0.08))
                    .overlay(
                        RoundedRectangle(cornerRadius: 28)
                            .stroke(Color.white.opacity(0.04), lineWidth: 0.5)
                    )
            )
            .shadow(color: Color.black.opacity(0.25), radius: 6, x: 0, y: 3)
        }
    }
}
 
// MARK: - BottomBar
 
struct BottomBar: View {
    var body: some View {
        HStack(spacing: 18) {
            TabItem(title: "Home", systemName: "house")
            Spacer()
            TabItem(title: "News", systemName: "doc.text")
            Spacer()
            TabItem(title: "Likes", systemName: "star")
            Spacer()
            
            // Bottone centrale (search)
            Button(action: {}) {
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.12))
                        .frame(width: 60, height: 60)
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .semibold))
                }
            }
        }
        .padding(.horizontal, 22)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 26)
                .fill(Color.white.opacity(0.08))
                .frame(height: 76)
        )
        .padding(.horizontal, 12)
        .padding(.bottom, 8)
    }
}
 
// MARK: - TabItem
 
struct TabItem: View {
    let title: String
    let systemName: String
    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: systemName)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
            Text(title)
                .font(.system(size: 12))
                .foregroundColor(.white)
        }
        .opacity(0.95)
    }
}
 
// MARK: - Preview
 
#Preview {
    CourseDetailView()
        .environment(\.colorScheme, .dark)
}
