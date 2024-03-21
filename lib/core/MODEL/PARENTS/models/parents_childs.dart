class Child {
  final int id;
  final String lastname;
  final String firstname;
  final String level;
  final String matiere;
  final String repetiteur;
  final String status;
  final String motif;

  Child({
    required this.id,
    required this.lastname,
    required this.firstname,
    required this.level,
    required this.matiere,
    required this.repetiteur,
    required this.status,
    required this.motif,
  });
}

List<Child> demoChild = [
  Child(
      id: 1,
      lastname: "ADANDE",
      firstname: "Richard",
      level: "Sixieme",
      matiere: "Mathematique",
      repetiteur: "FANOU Beaudoin",
      status: "Validé",
      motif: "Bien"
    ),
    Child(
      id: 2,
      lastname: "AHLONSOU",
      firstname: "Benoit",
      level: "Troisieme",
      matiere: "Mathematique",
      repetiteur: "AHO Miranda",
      status: "Non validé",
      motif: "Pas disponible"
    ),
    Child(
      id: 3,
      lastname: "ADJAGBA",
      firstname: "Rock",
      level: "Terminal",
      matiere: "SVT",
      repetiteur: "FATOKINSI Rony",
      status: "Validé",
      motif: "Bien"
    ),
];
