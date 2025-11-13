import SwiftUI

extension Color {
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
    private func categoryForTitle(_ title: String) -> Category? {
        categoriesData.first { $0.name.lowercased() == title.lowercased() }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "#102037")
                    .ignoresSafeArea()

                VStack(spacing: 40) {
                    VStack(spacing: 12) {
                        Text("DEPARTMENTS")
                            .font(.system(size: 36, weight: .heavy))
                            .foregroundColor(.white)
                    }
                    .padding(.top, 60)
                    .padding(.bottom, 60)
                    let columns = [
                        GridItem(.flexible(minimum: 150), spacing: 20),
                        GridItem(.flexible(minimum: 150), spacing: 20)
                    ]

                    LazyVGrid(columns: columns, spacing: 40) {
                        departmentButton(icon: "building.2", title: "Architecture")
                        departmentButton(icon: "cpu", title: "Engineering")
                        departmentButton(icon: "building.columns", title: "Law School")
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

    @ViewBuilder
    private func departmentButton(icon: String, title: String) -> some View {
        if let category = categoryForTitle(title) {
            NavigationLink(destination: CategoryCoursesView(category: category)) {
                buttonContent(icon: icon, title: title)
            }
        } else {
            Button(action: {
                print("Categoria \(title) non trovata")
            }) {
                buttonContent(icon: icon, title: title)
            }
        }
    }

    private func buttonContent(icon: String, title: String) -> some View {
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

// Assicurati di avere la view CategoryCoursesView come definita prima, ad esempio

struct CategoryCoursesView: View {
    let category: Category

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Text(category.name)
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.leading, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    VStack(spacing: 15) {
                        ForEach(category.courses) { course in
                            NavigationLink(destination: CourseDetailView(course: course)) {
                                CourseCardView(course: course)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.vertical)
            }
            .background(AppTheme.backgroundGradient)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CourseCardView: View {
    let course: Course

    var body: some View {
        HStack(spacing: 12) {
            Image(course.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipped()
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 4) {
                Text(course.name)
                    .font(.headline)
                    .foregroundColor(.white)
                    .lineLimit(1)
                Text(course.description)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                    .lineLimit(2)
            }
            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.15))
        .cornerRadius(20)
        .shadow(radius: 6, x: 0, y: 2)
    }
}

#Preview {
    if let firstCategory = categoriesData.first {
        DepartmentsView()
    }
}
