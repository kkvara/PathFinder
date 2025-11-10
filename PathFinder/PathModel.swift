import Foundation

// Struct to hold individual reviews
struct Review: Identifiable {
    let id = UUID()
    let text: String
}

struct Project: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let imageName: String
}

struct Course: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let university: String
    let imageName: String
    let reviews: [Review]             // Array di review (solo testi)
    let score: Double                 // Punteggio complessivo del corso
    let projects: [Project]?          // Lista opzionale di progetti collegati
    let locations: [String]
    let department: String
}

struct Category: Identifiable {
    let id = UUID()
    let name: String
    let played: Bool                  // Stato di "played" solo per la categoria principale
    let courses: [Course]             // Corsi che appartengono alla categoria
}

let categoriesData: [Category] = [
    Category(
        name: "Engineering",
        played: false,
        courses: [
            Course(
                name: "Aerospace Engineering",
                description: "Degree course focused on designing, developing and managing flying machines.",
                university: "Polytechnic of Milan",
                imageName: "aerospace",
                reviews: [
                    Review(text: "The teachers are helpful and very prepared."),
                    Review(text: "Nice combination of theory and practice.")
                ],
                score: 4.5,
                projects: nil,
                locations: ["Milan Campus"],
                department: "Engineering"
            ),
            Course(
                name: "Mechanical Engineering",
                description: "Comprehensive program focused on design and manufacturing of mechanical systems.",
                university: "Polytechnic of Milan",
                imageName: "mechanical",
                reviews: [
                    Review(text: "Strong focus on practical applications."),
                    Review(text: "Good balance of theory and lab work.")
                ],
                score: 4.4,
                projects: nil,
                locations: ["Milan Campus"],
                department: "Engineering"
            ),
            Course(
                name: "Electrical Engineering",
                description: "Program dedicated to electronics, power systems and telecommunications.",
                university: "Polytechnic of Milan",
                imageName: "electrical",
                reviews: [
                    Review(text: "Well-structured and challenging."),
                    Review(text: "Professors are highly knowledgeable.")
                ],
                score: 4.6,
                projects: nil,
                locations: ["Milan Campus"],
                department: "Engineering"
            )
        ]
    ),
    Category(
        name: "Architecture",
        played: false,
        courses: [
            Course(
                name: "Architectural Design",
                description: "Course focused on principles and techniques of architectural design.",
                university: "University of Rome",
                imageName: "architecture_design",
                reviews: [
                    Review(text: "Creative and inspiring classes."),
                    Review(text: "Good mix of theory and hands-on projects.")
                ],
                score: 4.3,
                projects: nil,
                locations: ["Rome Campus"],
                department: "Architecture"
            ),
            Course(
                name: "Urban Planning",
                description: "Study of development and design of urban environments.",
                university: "University of Rome",
                imageName: "urban_planning",
                reviews: [
                    Review(text: "Insightful and well structured."),
                    Review(text: "Real-world applications are very useful.")
                ],
                score: 4.5,
                projects: nil,
                locations: ["Rome Campus"],
                department: "Architecture"
            ),
            Course(
                name: "Landscape Architecture",
                description: "Course about the design of outdoor public areas and landscapes.",
                university: "University of Rome",
                imageName: "landscape_architecture",
                reviews: [
                    Review(text: "Engaging and practical."),
                    Review(text: "Focus on sustainability is appreciated.")
                ],
                score: 4.4,
                projects: nil,
                locations: ["Rome Campus"],
                department: "Architecture"
            )
        ]
    ),
    Category(
        name: "Medicine",
        played: false,
        courses: [
            Course(
                name: "General Medicine",
                description: "Complete training course to become a doctor, with theoretical and practical insights in the healthcare field.",
                university: "Sapienza University of Rome",
                imageName: "medicine",
                reviews: [
                    Review(text: "Challenging coursework, but satisfying."),
                    Review(text: "Grants a solid base for medical professions.")
                ],
                score: 4.7,
                projects: nil,
                locations: ["Rome Campus"],
                department: "Medical"
            ),
            Course(
                name: "Nursing",
                description: "Training focused on patient care and support in medical environments.",
                university: "Sapienza University of Rome",
                imageName: "nursing",
                reviews: [
                    Review(text: "Very practical and rewarding course."),
                    Review(text: "Excellent clinical practice opportunities.")
                ],
                score: 4.6,
                projects: nil,
                locations: ["Rome Campus"],
                department: "Medical"
            ),
            Course(
                name: "Pharmacy",
                description: "Program focused on drugs and pharmaceutical sciences.",
                university: "Sapienza University of Rome",
                imageName: "pharmacy",
                reviews: [
                    Review(text: "Highly informative and detailed."),
                    Review(text: "Good combination of theory and labs.")
                ],
                score: 4.5,
                projects: nil,
                locations: ["Rome Campus"],
                department: "Medical"
            )
        ]
    ),
    Category(
        name: "Law School",
        played: false,
        courses: [
            Course(
                name: "Law",
                description: "Path dedicated to the study of law, rules and legal procedures.",
                university: "University of Milan",
                imageName: "law",
                reviews: [
                    Review(text: "Entertaining and in-depth courses."),
                    Review(text: "Sometimes it's tough to keep up with the lessons.")
                ],
                score: 4.4,
                projects: nil,
                locations: ["Milan Campus"],
                department: "Law"
            ),
            Course(
                name: "International Law",
                description: "Study of laws governing relations between countries and international organizations.",
                university: "University of Milan",
                imageName: "international_law",
                reviews: [
                    Review(text: "Challenging but very enriching."),
                    Review(text: "Great insight into global issues.")
                ],
                score: 4.5,
                projects: nil,
                locations: ["Milan Campus"],
                department: "Law"
            ),
            Course(
                name: "Criminal Law",
                description: "Focus on laws related to crimes and punishment.",
                university: "University of Milan",
                imageName: "criminal_law",
                reviews: [
                    Review(text: "Very detailed and practical."),
                    Review(text: "Professors are very approachable.")
                ],
                score: 4.3,
                projects: nil,
                locations: ["Milan Campus"],
                department: "Law"
            )
        ]
    )
]
