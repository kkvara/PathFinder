struct Path {
    let name: String
    let description: String
    let university: String
    let testimonials: [String]
    let reviews: [String]
}

let pathsData: [Path] = [
    Path(
        name: "Ingegneria Aerospaziale",
        description: "Corso di laurea focalizzato sulla progettazione, sviluppo e gestione di veicoli spaziali e aeromobili.",
        university: "Politecnico di Torino",
        testimonials: [
            "Mi ha permesso di capire a fondo il settore aerospaziale.",
            "Le opportunità di stage in aziende leader sono state fondamentali."
        ],
        reviews: [
            "I docenti sono molto preparati e disponibili.",
            "Ottima combinazione tra teoria e pratica."
        ]
    ),
    Path(
        name: "Medicina",
        description: "Percorso formativo completo per diventare medico, con approfondimenti teorici e pratici in ambito sanitario.",
        university: "Università di Roma Sapienza",
        testimonials: [
            "La formazione clinica è molto completa e stimolante.",
            "Ho apprezzato molto i tirocini negli ospedali convenzionati."
        ],
        reviews: [
            "Il carico di studio è intenso ma soddisfacente.",
            "Ottima preparazione per affrontare la professione medica."
        ]
    ),
    Path(
        name: "Informatica",
        description: "Corso che fornisce competenze in programmazione, sistemi informatici, reti e sviluppo software.",
        university: "Università di Bologna",
        testimonials: [
            "Ottima base teorica e molte possibilità di applicazione pratica.",
            "Progetti di gruppo stimolanti e docenti preparati."
        ],
        reviews: [
            "I corsi sono aggiornati e in linea con le richieste del mercato.",
            "Ambiente molto stimolante e collaborativo."
        ]
    ),
    Path(
        name: "Giurisprudenza",
        description: "Percorso dedicato allo studio del diritto, delle norme e delle procedure legali.",
        university: "Università degli Studi di Milano",
        testimonials: [
            "Molto utile per chi vuole intraprendere la carriera legale.",
            "Ottima preparazione teorica e pratica."
        ],
        reviews: [
            "Le lezioni sono coinvolgenti e approfondite.",
            "Buon equilibrio tra diritto pubblico e privato."
        ]
    )
]
