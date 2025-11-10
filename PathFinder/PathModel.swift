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

struct Path: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let university: String
    let imageName: String
    let played: Bool
    let reviews: [Review]      // Array di review (solo testi)
    let score: Double          // Punteggio complessivo del percorso
    let projects: [Project]?   // Lista opzionale di progetti collegati
    let locations: [String]
    let department: String
}

let pathsData: [Path] = [
    Path(
        name: "Aerospace Engineering",
        description: "Degree course focused on designing, developing and managing flying machines.",
        university: "Polytechnic of Milan",
        imageName: "aerospace",
        played: false,
        reviews: [
            Review(text: "The teachers are helpful and very prepared."),
            Review(text: "Nice combination of theory and practice.")
        ],
        score: 4.5,
        projects: nil,
        locations: ["Milan Campus"],
        department: "Engineering"
    ),
    Path(
        name: "Medicine",
        description: "Complete training course to become a doctor, with theoretical and practical insights in the healthcare field.",
        university: "Sapienza University of Rome",
        imageName: "medicine",
        played: false,
        reviews: [
            Review(text: "Challenging coursework, but satisfying."),
            Review(text: "Grants a solid base for medical professions.")
        ],
        score: 4.7,
        projects: nil,
        locations: ["Rome Campus"],
        department: "Medical"
    ),
    Path(
        name: "Information Technology",
        description: "Undergraduate program granting programming skills and knowledge about systems, networks and software development.",
        university: "University of Bologna",
        imageName: "it",
        played: false,
        reviews: [
            Review(text: "Courses are frequently upgraded and up-to-date with what the market wants."),
            Review(text: "It's a really exciting and collaborative environment.")
        ],
        score: 4.6,
        projects: nil,
        locations: ["Bologna Campus"],
        department: "IT"
    ),
    Path(
        name: "Law",
        description: "Path dedicated to the study of law, rules and legal procedures.",
        university: "University of Milan",
        imageName: "law",
        played: false,
        reviews: [
            Review(text: "Entertaining and in-depth courses."),
            Review(text: "Sometimes it's tough to keep up with the lessons.")
        ],
        score: 4.4,
        projects: nil,
        locations: ["Milan Campus"],
        department: "Law"
    )
]
