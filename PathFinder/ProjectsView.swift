import SwiftUI

@available(iOS 26.0, *)
struct ProjectsView: View {
    let course: Course

    var body: some View {
        ZStack {
            AppTheme.backgroundGradient.ignoresSafeArea()

            VStack(spacing: 18) {
                VStack(spacing: 8) {
                    Image(systemName: "ruler")
                        .font(.system(size: 36))
                        .foregroundColor(.white)
                    Text("PROJECTS")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                }

                ScrollView {
                    VStack(spacing: 24) {
                        if let projects = course.projects, !projects.isEmpty {
                            ForEach(projects) { proj in
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(proj.name)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Text(proj.description)
                                        .font(.subheadline)
                                        .foregroundColor(.white.opacity(0.8))

                                    if !course.imageName.isEmpty {
                                        Image(uiImage: UIImage(named: proj.imageName)!)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(height: 130)
                                            .clipped()
                                            .cornerRadius(16)
                                            .shadow(radius: 8)
                                    }
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 16).fill(AppTheme.darkCardColor.opacity(0.5)))
                                .padding(.horizontal)
                            }
                        } else {
                            Text("No projects for this course.")
                                .foregroundColor(.white.opacity(0.8))
                                .padding()
                        }
                    }
                    .padding(.top, 12)
                }

                Spacer()
            }
            .padding(.top)
        }
        .navigationBarBackButtonHidden(false)
    }
}
