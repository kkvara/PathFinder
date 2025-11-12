import Foundation
import Combine

struct LocationDetail: Identifiable, Codable {
    let id: UUID
    let name: String
    let address: String
    let latitude: Double
    let longitude: Double
    let imageName: String

    init(id: UUID = UUID(), name: String, address: String, latitude: Double, longitude: Double, imageName: String) {
        self.id = id
        self.name = name
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.imageName = imageName
    }
}

// Struct to hold individual reviews
struct Review: Identifiable, Codable {
    let id: UUID
    let text: String
    let rating: Int  // Nuovo campo da 1 a 5

    init(id: UUID = UUID(), text: String, rating: Int) {
        self.id = id
        self.text = text
        self.rating = rating
    }
}


struct Project: Identifiable, Codable {
    let id: UUID
    let name: String
    let imageName: String       // Nuovo campo immagine progetto
    let description: String

    init(id: UUID = UUID(), name: String, imageName: String, description: String) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.description = description
    }
}

struct Course: Identifiable, Codable {
    let id: UUID
    let name: String
    let description: String
    let imageName: String
    let university: String
    let reviews: [Review]
    let score: Double
    let projects: [Project]?
    let locations: [LocationDetail]
    let department: String
    let iconName: String
    var isFavorite: Bool

    init(
        id: UUID = UUID(),
        name: String,
        description: String,
        university: String,
        imageName: String,
        reviews: [Review] = [],
        score: Double = 0.0,
        projects: [Project]? = nil,
        locations: [LocationDetail] = [],
        department: String = "",
        iconName: String = "",
        isFavorite: Bool = false
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.imageName = imageName
        self.university = university
        self.reviews = reviews
        self.score = score
        self.projects = projects
        self.locations = locations
        self.department = department
        self.iconName = iconName
        self.isFavorite = isFavorite
    }
}

struct Category: Identifiable {
    let id = UUID()
    let name: String
    var played: Bool                  // Stato di "played" solo per la categoria principale
    let courses: [Course]             // Corsi che appartengono alla categoria
}

struct News: Identifiable, Codable {
    let id: UUID
    let title: String
    let summary: String
    let content: String
    let imageName: String  // opzione per immagine associata

    init(id: UUID = UUID(), title: String, summary: String, content: String, imageName: String) {
        self.id = id
        self.title = title
        self.summary = summary
        self.content = content
        self.imageName = imageName
    }
}

var allNews: [News] = [
        News(title: "Titolo 1", summary: "Breve sommario 1", content: "Contenuto completo news 1", imageName: "image1"),
        News(title: "Titolo 2", summary: "Breve sommario 2", content: "Contenuto completo news 2", imageName: "image2"),
        // ...
    ]

var categoriesData: [Category] = [
        Category(
            name: "Engineering",
            played: false,
            courses: [
                Course(
                    name: "Aerospace Engineering",
                    description: "This program trains engineers in the design and maintenance of aircraft and spacecraft. It is selective and complex, with an interdisciplinary approach combining mechanics, materials science, and fluid dynamics.",
                    university: "Università degli studi di Napoli Federico II",
                    imageName: "aerospace",
                    reviews: [
                        Review(text: "The teachers are helpful and very prepared.", rating: 5),
                        Review(text: "Nice combination of theory and practice.", rating: 4)
                    ],
                    score: 4.5,
                    projects: nil,
                    locations: [LocationDetail(name: "San Giovanni Campus",
                                             address: "Via Rossi 10, Milan",
                                             latitude: 45.464211,
                                             longitude: 9.191383,
                                             imageName: "San giovanni ing"),
                                LocationDetail(name: "Via Claudio",
                                                         address: "Via Rossi 10, Milan",
                                                         latitude: 45.464211,
                                                         longitude: 9.191383,
                                                         imageName: "Via claudio ing"),
                                LocationDetail(name: "Agnano",
                                                         address: "Via Rossi 10, Milan",
                                                         latitude: 45.464211,
                                                         longitude: 9.191383,
                                                         imageName: "agnano ing"),
                                LocationDetail(name: "Piazzale Tecchio",
                                                         address: "Via Rossi 10, Milan",
                                                         latitude: 45.464211,
                                                         longitude: 9.191383,
                                                         imageName: "Tecchio ing")
                    ],
                    department: "Engineering",
                    iconName: "airplane.up.forward"
                ),
                Course(
                    name: "Civil Engineering",
                    description: "Dedicated to infrastructure, construction, and land management. Students learn structural analysis, hydraulics, transportation, and geotechnics.",
                    university: "Università degli studi di Napoli Federico II",
                    imageName: "civil",
                    reviews: [
                        Review(text: "Strong focus on practical applications.", rating: 4),
                        Review(text: "Good balance of theory and lab work.", rating: 3)
                    ],
                    score: 4.4,
                    projects: nil,
                    locations:  [LocationDetail(name: "San Giovanni Campus",
                                                address: "Via Rossi 10, Milan",
                                                latitude: 45.464211,
                                                longitude: 9.191383,
                                                imageName: "San giovanni ing"),
                                   LocationDetail(name: "Via Claudio",
                                                            address: "Via Rossi 10, Milan",
                                                            latitude: 45.464211,
                                                            longitude: 9.191383,
                                                            imageName: "Via claudio ing"),
                                   LocationDetail(name: "Agnano",
                                                            address: "Via Rossi 10, Milan",
                                                            latitude: 45.464211,
                                                            longitude: 9.191383,
                                                            imageName: "agnano ing"),
                                   LocationDetail(name: "Piazzale Tecchio",
                                                            address: "Via Rossi 10, Milan",
                                                            latitude: 45.464211,
                                                            longitude: 9.191383,
                                                            imageName: "Tecchio ing")
                       ],
                    department: "Engineering",
                    iconName: "gearshape.2.fill"
                ),
                Course(
                    name: "Electrical Engineering",
                    description: "A three-year degree program focused on the design and management of electronic systems, sensors, circuits, and digital components. It is highly theoretical, with a strong foundation in mathematics and physics.",
                    university: "Università degli studi di Napoli Federico II",
                    imageName: "electrical",
                    reviews: [
                        Review(text: "Well-structured and challenging.", rating: 4),
                        Review(text: "Professors are highly knowledgeable.", rating: 5)
                    ],
                    score: 4.6,
                    projects: nil,
                    locations:  [LocationDetail(name: "San Giovanni Campus",
                                                address: "Via Rossi 10, Milan",
                                                latitude: 45.464211,
                                                longitude: 9.191383,
                                                imageName: "San giovanni ing"),
                                   LocationDetail(name: "Via Claudio",
                                                            address: "Via Rossi 10, Milan",
                                                            latitude: 45.464211,
                                                            longitude: 9.191383,
                                                            imageName: "Via claudio ing"),
                                   LocationDetail(name: "Agnano",
                                                            address: "Via Rossi 10, Milan",
                                                            latitude: 45.464211,
                                                            longitude: 9.191383,
                                                            imageName: "agnano ing"),
                                   LocationDetail(name: "Piazzale Tecchio",
                                                            address: "Via Rossi 10, Milan",
                                                            latitude: 45.464211,
                                                            longitude: 9.191383,
                                                            imageName: "Tecchio ing")
                       ],
                    department: "Engineering",
                    iconName: "lightbulb.min.fill"
                )
            ]
        ),
        Category(
            name: "Architecture",
            played: false,
            courses: [
                Course(
                    name: "Community design",
                    description: "Community design is the first and only three-year design program at Federico II University. \n\nThe course provides the fundamentals of various branches of design, such as Graphic Design, Interior Design, Web Design, UI & UX Design, and Community Design.",
                    university: "Università degli studi di Napoli Federico II",
                    imageName: "Community design",
                    reviews: [
                        Review(text: "Creative and inspiring classes.", rating: 3),
                        Review(text: "Good mix of theory and hands-on projects.", rating: 4)
                    ],
                    score: 4.3,
                    projects: [
                                            Project(name: "SubAquea", imageName: "SubAquea", description: "Product Design - 2° Year"),
                                            Project(name: "Opera Omnia", imageName: "Opera Omnia", description: "Innovation Design - 3° Year")
                                        ],
                    locations: [LocationDetail(name: "Forno Vecchio",
                                             address: "Via Rossi 10, Milan",
                                             latitude: 45.464211,
                                             longitude: 9.191383,
                                             imageName: "forno vecchio"),
                                LocationDetail(
                                             name: "Palazzo Gravina",
                                             address: "Via Dante, 5, Milan",
                                             latitude: 45.4668,
                                             longitude: 9.1905,
                                             imageName: "palazzo gravina")],
                    department: "Architecture",
                    iconName: "house.fill"
                ),
                Course(
                    name: "Architectural Sciences",
                    description: "A three-year program introducing students to architectural, urban, and landscape design. It covers drawing, art history, technology, structural design, and representation. The course is demanding highly theoretical in the first years and more design-oriented in the workshops.",
                    university: "Università degli studi di Napoli Federico II",
                    imageName: "science",
                    reviews: [
                        Review(text: "Insightful and well structured.", rating: 4),
                        Review(text: "No Real-world applications.", rating: 2)
                    ],
                    score: 4.5,
                    projects: nil,
                    locations: [LocationDetail(name: "Forno Vecchio",
                                              address: "Via Rossi 10, Milan",
                                              latitude: 45.464211,
                                              longitude: 9.191383,
                                              imageName: "forno vecchio"),
                                 LocationDetail(
                                              name: "Palazzo Gravina",
                                              address: "Via Dante, 5, Milan",
                                              latitude: 45.4668,
                                              longitude: 9.1905,
                                              imageName: "palazzo gravina")],
                    department: "Architecture",
                    iconName: "map.fill"
                ),
                Course(
                    name: "Sustainable Urban Planning",
                    description: "Course about the design of outdoor public areas and landscapes.",
                    university: "Università degli studi di Napoli Federico II",
                    imageName: "urban",
                    reviews: [
                        Review(text: "Engaging and practical.", rating: 3),
                        Review(text: "Focus on sustainability is appreciated.", rating: 3)
                    ],
                    score: 4.4,
                    projects: nil,
                    locations: [LocationDetail(name: "Forno Vecchio",
                                               address: "Via Rossi 10, Milan",
                                               latitude: 45.464211,
                                               longitude: 9.191383,
                                               imageName: "forno vecchio"),
                                  LocationDetail(
                                               name: "Palazzo Gravina",
                                               address: "Via Dante, 5, Milan",
                                               latitude: 45.4668,
                                               longitude: 9.1905,
                                               imageName: "palazzo gravina")],
                    department: "Architecture",
                    iconName: "leaf.fill"
                )
            ]
        ),
        Category(
            name: "Medicine",
            played: false,
            courses: [
                Course(
                    name: "Pediatric Nursing",
                    description: "A specialized track focused on nursing care for children and adolescents. It combines medical and relational skills aimed at supporting both patients and their families.",
                    university: "Università degli studi di Napoli Federico II",
                    imageName: "pediatric",
                    reviews: [
                        Review(text: "Challenging coursework, but satisfying.", rating: 3),
                        Review(text: "Grants a solid base for medical professions.", rating: 4)
                    ],
                    score: 4.7,
                    projects: nil,
                    locations: [LocationDetail(name: "Policlinico",
                                             address: "Via Rossi 10, Milan",
                                             latitude: 45.464211,
                                             longitude: 9.191383,
                                             imageName: "policlinico med"),
                                LocationDetail(name: "Scampia",
                                                         address: "Via Rossi 10, Milan",
                                                         latitude: 45.464211,
                                                         longitude: 9.191383,
                                                         imageName: "scampia med")],
                    department: "Medical",
                    iconName: "syringe.fill"
                ),
                Course(
                    name: "Nursing",
                    description: "A three-year professional program that trains nurses to work in hospitals, clinics, and care facilities. It alternates theory with extensive internships.",
                    university: "Università degli studi di Napoli Federico II",
                    imageName: "nursing",
                    reviews: [
                        Review(text: "Very practical and rewarding course.", rating: 5),
                        Review(text: "Excellent clinical practice opportunities.", rating: 4)
                    ],
                    score: 4.6,
                    projects: nil,
                    locations:  [LocationDetail(name: "Policlinico",
                                                address: "Via Rossi 10, Milan",
                                                latitude: 45.464211,
                                                longitude: 9.191383,
                                                imageName: "policlinico med"),
                                   LocationDetail(name: "Scampia",
                                                            address: "Via Rossi 10, Milan",
                                                            latitude: 45.464211,
                                                            longitude: 9.191383,
                                                            imageName: "scampia med")],
                    department: "Medical",
                    iconName: "heart.fill"
                ),
                Course(
                    name: "Dietetics",
                    description: "A course centered on diet, nutrition, and health prevention. It combines biology, physiology, and medical sciences. Ideal for those seeking a healthcare career less tied to clinical emergencies and more focused on wellness and nutritional consulting.",
                    university: "Università degli studi di Napoli Federico II",
                    imageName: "dietetics",
                    reviews: [
                        Review(text: "Highly informative and detailed.", rating: 3),
                        Review(text: "Good combination of theory and labs.", rating: 4)
                    ],
                    score: 4.5,
                    projects: nil,
                    locations:  [LocationDetail(name: "Policlinico",
                                                address: "Via Rossi 10, Milan",
                                                latitude: 45.464211,
                                                longitude: 9.191383,
                                                imageName: "policlinico med"),
                                   LocationDetail(name: "Scampia",
                                                            address: "Via Rossi 10, Milan",
                                                            latitude: 45.464211,
                                                            longitude: 9.191383,
                                                            imageName: "scampia med")],
                    department: "Medical",
                    iconName: "pills.fill"
                )
            ]
        ),
        Category(
            name: "Law School",
            played: false,
            courses: [
                Course(
                    name: "Legal Services Sciences",
                    description: "A three-year program providing a solid legal foundation with practical applications in labor, nonprofit, and business sectors. Less theoretical than traditional law degrees, and more oriented toward administrative and managerial employment.",
                    university: "Università degli studi di Napoli Federico II",
                    imageName: "legal",
                    reviews: [
                        Review(text: "Entertaining and in-depth courses.", rating: 5),
                        Review(text: "Sometimes it's tough to keep up with the lessons.", rating: 2)
                    ],
                    score: 4.4,
                    projects: nil,
                    locations: [LocationDetail(name: "Via Marina",
                                             address: "Via Rossi 10, Milan",
                                             latitude: 45.464211,
                                             longitude: 9.191383,
                                             imageName: "via marina giur"),
                                LocationDetail(name: "Centrale",
                                                         address: "Via Rossi 10, Milan",
                                                         latitude: 45.464211,
                                                         longitude: 9.191383,
                                                         imageName: "centrale giur")],
                    department: "Law",
                    iconName: "book.fill"
                ),
                Course(
                    name: "Law for Business and Public Administration",
                    description: "A course focused on the relationship between law and economics. It trains professionals able to interpret and manage business and administrative regulations. Less “forensic,” more technical and managerial in nature.",
                    university: "Università degli studi di Napoli Federico II",
                    imageName: "business",
                    reviews: [
                        Review(text: "Challenging but very enriching.", rating: 3),
                        Review(text: "Great insight into global issues.", rating: 5)
                    ],
                    score: 4.5,
                    projects: nil,
                    locations: [LocationDetail(name: "Milan Campus",
                                             address: "Via Rossi 10, Milan",
                                             latitude: 45.464211,
                                             longitude: 9.191383,
                                             imageName: "milanCampusImage")],
                    department: "Law",
                    iconName: "globe.fill"
                ),
                Course(
                    name: "Legal Operator for Immigration and the Third Sector",
                    description: "A program centered on human rights, migration, and social inclusion. It combines international law, mediation, and social policy studies. An innovative yet less traditional path compared to classic legal degrees.",
                    university: "Università degli studi di Napoli Federico II",
                    imageName: "third",
                    reviews: [
                        Review(text: "Very detailed and practical.", rating: 4),
                        Review(text: "Professors are very approachable.", rating: 4)
                    ],
                    score: 4.3,
                    projects: nil,
                    locations: [LocationDetail(name: "Milan Campus",
                                             address: "Via Rossi 10, Milan",
                                             latitude: 45.464211,
                                             longitude: 9.191383,
                                             imageName: "milanCampusImage")],
                    department: "Law",
                    iconName: "lock.fill"
                )
            ]
        )
    ]

struct PathModel {
    // Controlla se almeno una categoria è "played"
    static func hasAnyCategoryPlayed(categories: [Category]) -> Bool {
        categories.contains(where: { $0.played })
    }

    // Imposta played a true per una categoria (passa il nome o id)
    static func setCategoryPlayed(categories: inout [Category], categoryName: String) {
        if let index = categories.firstIndex(where: { $0.name == categoryName }) {
            categories[index].played = true
        }
    }
}


