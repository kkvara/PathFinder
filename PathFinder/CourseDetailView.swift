import SwiftUI

struct CourseDetailView: View {
    let course: Course
    
    var body: some View {
        ZStack {
            // Sfondo con il gradiente definito nel file Constants.swift
            AppTheme.backgroundGradient
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // Icona del corso (presa da SF Symbols)
                    Image(systemName: course.iconName)
                        .font(.system(size: 60))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 30)

                    
                    // Titolo del corso
                    Text(course.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    
                    // Università
                    Text(course.university)
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.horizontal)
                    
                    // Descrizione
                    Text(course.description)
                        .font(.body)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    
                    // Dipartimento e località
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Department: \(course.department)")
                            .foregroundColor(.white)
                            .font(.subheadline)
                        
                        if !course.locations.isEmpty {
                            Text("Locations: \(course.locations.joined(separator: ", "))")
                                .foregroundColor(.white)
                                .font(.subheadline)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Punteggio del corso
                    HStack(spacing: 6) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text(String(format: "%.1f", course.score))
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    .padding(.horizontal)
                    
                    Divider()
                        .background(Color.white.opacity(0.3))
                        .padding(.horizontal)
                    
                    // Sezione recensioni
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Reviews")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        
                        ForEach(course.reviews) { review in
                            Text("“\(review.text)”")
                                .font(.body)
                                .foregroundColor(.white.opacity(0.9))
                                .padding(.vertical, 6)
                                .padding(.horizontal)
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Sezione progetti collegati (se presenti)
                    if let projects = course.projects, !projects.isEmpty {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Related Projects")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            
                            ForEach(projects) { project in
                                VStack(alignment: .leading) {
                                    Text(project.name)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Text(project.description)
                                        .font(.subheadline)
                                        .foregroundColor(.white.opacity(0.9))
                                }
                                .padding()
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(10)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 50)
                }
                .padding(.top)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
