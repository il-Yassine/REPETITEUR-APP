class Student {
  final int id;
  final String lastname;
  final String firstname;
  final String phone;
  final String address;
  final String studentClass;
  final String course;
  final String teacher;
 /*  final String description;
  final String classe;
  final String matiere;
  final String disponibilite;
  final String situation_matrimoniale;
  final String ecole_de_provenance;
  final String grade;
  final String niveau_etude;
  final String experience_professionnelle;
  final List<String> imageUrl; */

  Student({
    required this.id,
    required this.lastname,
    required this.firstname,
    required this.phone,
    required this.address,
    required this.studentClass,
    required this.course,
    required this.teacher,
    /* 
    required this.imageUrl,
    required this.description,
    required this.classe,
    required this.matiere,
    required this.disponibilite,
    required this.situation_matrimoniale,
    required this.ecole_de_provenance,
    required this.grade,
    required this.niveau_etude,
    required this.experience_professionnelle, */
  });
}

List<Student> demoStudent = [
  Student(
    id: 1,
    firstname: "Anthony",
    lastname: "GIGGS",
    address: "Bénin, Abomey-Calavi",
    phone: '',
    studentClass: "6eme",
    course: "Mathematique General",
    teacher: "Pierre Paul de SOUZA"
   /*  address: "Bénin, Abomey-Calavi",
    imageUrl: ["assets/images/1.jpg"],
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce convallis, tortor id placerat suscipit, arcu.",
    classe: "Terminale (Scientifique)",
    matiere: "Mathématique Générale",
    disponibilite: "Mercredi 14h-18h; Samedi 15h-18h",
    situation_matrimoniale: "Célibataire",
    ecole_de_provenance: "Sainte Felicite",
    grade: "ACE",
    niveau_etude: "Master",
    experience_professionnelle: "3 ans", */
  ),
  Student(
    id: 2,
    firstname: "Moario",
    lastname: "BUGATTI",
    address: "Bénin, Litoral, Cotonou",
    phone: '',
    studentClass: "3eme",
    course: "Mathematique General",
    teacher: "Pierre Paul de SOUZA",
    /* 
    imageUrl: ["assets/images/2.jpg"],
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce convallis, tortor id placerat suscipit, arcu.",
    classe: "Troisieme Moderne Court (3eme MC)",
    matiere: "Science de la Vie et de la Terre (SVT)",
    disponibilite: "Mercredi 15h-18h; Samedi 09h-12h",
    situation_matrimoniale: "Célibataire",
    ecole_de_provenance: "Sainte Bakhita",
    grade: "ACE",
    niveau_etude: "License",
    experience_professionnelle: "1 ans", */
  ),
  Student(
    id: 3,
    firstname: "Samuel",
    lastname: "KENNY",
    address: "Bénin, Cotonou",
    phone: '',
    studentClass: "2nd",
    course: "Mathematique General",
    teacher: "Pierre Paul de SOUZA"
    /*
    imageUrl: ["assets/images/3.jpg"],
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce convallis, tortor id placerat suscipit, arcu.",
    classe: "Cinquieme Moderne Court (5eme MC)",
    matiere: "Physique, Chimie et Technologie (PCT)",
    disponibilite: "Mercredi 15h-18h; Samedi 10h-13h",
    situation_matrimoniale: "Marié",
    ecole_de_provenance: "CEG LA VERDURE",
    grade: "APE",
    niveau_etude: "Maitrise",
    experience_professionnelle: "5 ans", */
  ),
  Student(
    id: 4,
    firstname: "Michel",
    lastname: "DUBEC",
    address: "Bénin, Abomey-Calavi",
    phone: '',
    studentClass: "Terminal",
    course: "Mathematique General",
    teacher: "Pierre Paul de SOUZA",
    /* 
    imageUrl: ["assets/images/4.jpg"],
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce convallis, tortor id placerat suscipit, arcu.",
    classe: "Seconde Moderne Court (2nd MC)",
    matiere: "Anglais",
    disponibilite: "Mercredi 17h-20h; Samedi 09h-12h",
    situation_matrimoniale: "Divorcé",
    ecole_de_provenance: "Complexe Scolaire Clé de la réussite",
    grade: "APE",
    niveau_etude: "Doctorat",
    experience_professionnelle: "6 ans", */
  ),
  Student(
    id: 5,
    firstname: "Claude",
    lastname: "LAVOISIER",
    address: "Bénin, Abomey-Calavi", 
    phone: '',
    studentClass: "4eme",
    course: "Mathematique General",
    teacher: "Pierre Paul de SOUZA",

    /* imageUrl: ["assets/images/repetiteur2.jpg"],
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce convallis, tortor id placerat suscipit, arcu.",
    classe: "Première Moderne Court (1ère MC)",
    matiere: "Français",
    disponibilite: "Mercredi 15h-18h; Samedi 09h-12h",
    situation_matrimoniale: "Marié",
    ecole_de_provenance: "Jean Piaget",
    grade: "ACE",
    niveau_etude: "License",
    experience_professionnelle: "2 ans", */
  ),
];
