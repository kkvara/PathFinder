import SwiftUI

struct HomeNGameView: View {
    @State private var showFullLeaderboard = false
    @State private var pulse = false
    
    private func averageRating(for course: Course) -> Double {
        guard !course.reviews.isEmpty else { return 0.0 }
        let totalRating = course.reviews.reduce(0) { $0 + $1.rating }
        return Double(totalRating) / Double(course.reviews.count)
    }
    
    private var leaderboardByRating: [(course: Course, averageRating: Double)] {
        categoriesData.flatMap { $0.courses }
            .map { course in
                (course: course, averageRating: averageRating(for: course))
            }
            .sorted { $0.averageRating > $1.averageRating }
    }
    
    private var allCoursesSorted: [Course] {
        categoriesData.flatMap { $0.courses }
            .sorted { $0.name < $1.name }
    }
    
 
        var body: some View {
            NavigationStack {
                ZStack {
                    AppTheme.backgroundGradient
                        .ignoresSafeArea()
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            Text("Click here to discover your path")
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                                .foregroundColor(.white)
                                .padding(.top, 60)
                                .transition(.opacity)
                                .padding(.bottom, 40)
                            
                            // Button with extra padding
                            NavigationLink(destination: CrystalBallView()) {
                                ZStack {
                                    Circle()
                                        .fill(
                                            RadialGradient(
                                                gradient: Gradient(colors: [
                                                    Color.cyan.opacity(0.6),
                                                    Color.blue.opacity(0.4)
                                                ]),
                                                center: .center,
                                                startRadius: 0,
                                                endRadius: 150
                                            )
                                        )
                                        .shadow(color: Color.cyan.opacity(0.5), radius: 15, x: 0, y: 0)
                                        
                                    Image("Crystal_Ball_white")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 75, height: 75)
                                        .shadow(color: Color.white.opacity(0.3), radius: 5, x: 0, y: 0)
                                }
                                .frame(width: 160, height: 160)
                                .scaleEffect(pulse ? 1.1 : 1.0, anchor: .center)
                                .padding(.bottom, 24)
                                .onAppear {
                                    withAnimation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                                        pulse = true
                                    }
                                }

                                .frame(width: 160, height: 160)
                                .scaleEffect(pulse ? 1.02 : 1.0, anchor: .center)
                                .padding(.bottom, 24) // <-- padding BETWEEN button and next section
                            }
                            
                            Text("Recommended Paths For You")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, 8) // <-- more gap before horizontal list
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 0) {
                                    ForEach(allCoursesSorted) { course in
                                        NavigationLink(destination: CourseDetailView(course: course)) {
                                            ZStack(alignment: .bottomLeading) {
                                                Image(course.imageName)
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 280, height: 160)
                                                    .cornerRadius(15)
                                                    .clipped()
                                                
                                                LinearGradient(
                                                    gradient: Gradient(colors: [Color.black.opacity(0.6), Color.clear]),
                                                    startPoint: .bottom,
                                                    endPoint: .center
                                                )
                                                .cornerRadius(15)
                                                
                                                Text(course.name)
                                                    .font(.headline)
                                                    .bold()
                                                    .foregroundColor(.white)
                                                    .padding()
                                            }
                                            .frame(width: 280, height: 160)
                                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                                            .padding(.horizontal)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                            .padding(.bottom, 28) // <-- more gap after course images
                            
                            // Section for List of Departments
                            NavigationLink(destination: DepartmentsView()) {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("List of Departments")
                                        .font(.system(size: 28, weight: .heavy, design: .rounded))
                                        .foregroundColor(.white)
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.white.opacity(0.7), lineWidth: 2)
                                )
                                .padding(.horizontal)
                            }
                            .padding(.bottom, 20) // <-- more gap before ranking section
                            
                            VStack(alignment: .leading, spacing: 14) {
                                Text("Ranking of courses")
                                    .font(.title2)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.white)
                                    .padding(.bottom, 8)
                                
                                ForEach(showFullLeaderboard ? leaderboardByRating : Array(leaderboardByRating.prefix(3)), id: \.course.id) { entry in
                                    HStack(spacing: 8) {
                                        ZStack {
                                            Circle()
                                                .fill(Color.blue.opacity(0.8))
                                                .frame(width: 28, height: 28)
                                            Text("\(leaderboardByRating.firstIndex(where: { $0.course.id == entry.course.id })! + 1)")
                                                .font(.subheadline)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                        }
                                        
                                        NavigationLink(destination: CourseDetailView(course: entry.course)) {
                                            Text(entry.course.name)
                                                .foregroundColor(.white)
                                                .font(.system(.body, design: .rounded))
                                                .bold()
                                        }
                                        
                                        Spacer()
                                        
                                        Text(String(format: "%.1f average rating", entry.averageRating))
                                            .foregroundColor(.white.opacity(0.8))
                                            .font(.system(.body, design: .rounded))
                                    }
                                    .padding(.vertical, 4)
                                }
                                
                                Button(action: {
                                    withAnimation {
                                        showFullLeaderboard.toggle()
                                    }
                                }) {
                                    Text(showFullLeaderboard ? "Show less" : "Show more")
                                        .font(.callout)
                                        .foregroundColor(.blue.opacity(0.7))
                                        .padding(.top, 8)
                                }
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 20)
                            
                            Spacer(minLength: 20)
                        }
                    }
                }
            }
        }
    }

#Preview {
    HomeNGameView()
}
