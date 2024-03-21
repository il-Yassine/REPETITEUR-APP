class Teacher {
  final int id;
  final String? nom;
  final String address;
  final String description;
  final String classe;
  final String matiere;
  final String disponibilite;
  final String situation_matrimoniale;
  final String ecole_de_provenance;
  final String grade;
  final String niveau_etude;
  final String experience_professionnelle;
  final List<String> imageUrl;
  final String matricule;
  final String cycle;
  final String statut;
  final String availablilty;
  final String evaluate;

  Teacher({
    required this.id,
    this.nom,
    required this.address,
    required this.imageUrl,
    required this.description,
    required this.classe,
    required this.matiere,
    required this.disponibilite,
    required this.situation_matrimoniale,
    required this.ecole_de_provenance,
    required this.grade,
    required this.niveau_etude,
    required this.experience_professionnelle,
    required this.matricule,
    required this.cycle,
    required this.statut,
    required this.availablilty,
    required this.evaluate
  });
}

List<Teacher> demoTeacher = [
  Teacher(
    id: 1,
    nom: "Anthony GIGGS",
    address: "Bénin, Abomey-Calavi",
    imageUrl: ["assets/images/1.jpg"],
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce convallis, tortor id placerat suscipit, arcu.",
    classe: "Terminale (Scientifique)",
    matiere: "Mathématique Générale",
    disponibilite: "Mercredi 14h-18h; Samedi 15h-18h",
    situation_matrimoniale: "Célibataire",
    ecole_de_provenance: "Sainte Felicite",
    grade: "ACE",
    niveau_etude: "Master",
    experience_professionnelle: "3 ans",
    matricule: "M000000112",
    cycle: "Secondaire",
    statut: "Etudiants",
    availablilty: "Disponible",
    evaluate: "Evaluer",
  ),
  Teacher(
    id: 2,
    nom: "Moario BUGATTI",
    address: "Bénin, Litoral, Cotonou",
    imageUrl: ["assets/images/2.jpg"],
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce convallis, tortor id placerat suscipit, arcu.",
    classe: "Troisieme Moderne Court (3eme MC)",
    matiere: "Science de la Vie et de la Terre (SVT)",
    disponibilite: "Mercredi 15h-18h; Samedi 09h-12h",
    situation_matrimoniale: "Célibataire",
    ecole_de_provenance: "Sainte Bakhita",
    grade: "ACE",
    niveau_etude: "License",
    experience_professionnelle: "1 ans",
    matricule: "M000000452",
    cycle: "Secondaire",
    statut: "Etudiants",
    availablilty: "Disponible",
    evaluate: "Evalué",
  ),
  Teacher(
    id: 3,
    nom: "Samuel KENNY",
    address: "Bénin, Cotonou",
    imageUrl: ["assets/images/3.jpg"],
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce convallis, tortor id placerat suscipit, arcu.",
    classe: "Cinquieme Moderne Court (5eme MC)",
    matiere: "Physique, Chimie et Technologie (PCT)",
    disponibilite: "Mercredi 15h-18h; Samedi 10h-13h",
    situation_matrimoniale: "Marié",
    ecole_de_provenance: "CEG LA VERDURE",
    grade: "APE",
    niveau_etude: "Maitrise",
    experience_professionnelle: "5 ans",
    matricule: "M000000880",
    cycle: "Universtaire",
    statut: "Enseignant-Professeur",
    availablilty: "Disponible",
    evaluate: "Evalué",
  ),
  Teacher(
    id: 4,
    nom: "Michel DUBEC",
    address: "Bénin, Abomey-Calavi",
    imageUrl: ["assets/images/4.jpg"],
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce convallis, tortor id placerat suscipit, arcu.",
    classe: "Seconde Moderne Court (2nd MC)",
    matiere: "Anglais",
    disponibilite: "Mercredi 17h-20h; Samedi 09h-12h",
    situation_matrimoniale: "Divorcé",
    ecole_de_provenance: "Complexe Scolaire Clé de la réussite",
    grade: "APE",
    niveau_etude: "Doctorat",
    experience_professionnelle: "6 ans",
    matricule: "M000000664",
    cycle: "Secondaire",
    statut: "Etudiants",
    availablilty: "Non disponible",
    evaluate: "Non évalué",
  ),
  Teacher(
    id: 5,
    nom: "Claude LAVOISIER",
    address: "Bénin, Abomey-Calavi",
    imageUrl: ["assets/images/repetiteur2.jpg"],
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce convallis, tortor id placerat suscipit, arcu.",
    classe: "Première Moderne Court (1ère MC)",
    matiere: "Français",
    disponibilite: "Mercredi 15h-18h; Samedi 09h-12h",
    situation_matrimoniale: "Marié",
    ecole_de_provenance: "Jean Piaget",
    grade: "ACE",
    niveau_etude: "License",
    experience_professionnelle: "2 ans",
    matricule: "M000000974",
    cycle: "Secondaire",
    statut: "Etudiants",
    availablilty: "Non Disponible",
    evaluate: "Evalué",
  ),
];
