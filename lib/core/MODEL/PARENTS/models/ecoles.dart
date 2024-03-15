
class School {
  final int id;
  final String nom;
  final String address;
  final String contacts;
  final List<String> imageUrl;

  School({
    required this.id,
    required this.nom,
    required this.address,
    required this.imageUrl,
    required this.contacts,
  });

  static School generateEcole() {
    return School(
        id: 1,
        nom: "Jean PIAGET I",
        address: "Bénin, Abomey-Calavi",
        imageUrl: ["assets/images/jp1.jpg"],
        contacts: "65656564");
  }
}

List<School> demoEcole = [
  School(
      id: 1,
      nom: "Jean PIAGET I",
      address: "Bénin, Abomey-Calavi",
      imageUrl: ["assets/images/jp1.jpg"],
      contacts: "65656564"),
  School(
      id: 2,
      nom: "Jean PIAGET II",
      address: "Bénin, Litoral, Cotonou",
      imageUrl: ["assets/images/jp2.jpg"],
      contacts: "95964521"),
  School(
      id: 3,
      nom: "Jean PIAGET III",
      address: "Bénin, Cotonou",
      imageUrl: ["assets/images/jp3.jpg"],
      contacts: "66686442"),
  School(
      id: 4,
      nom: "SAINTE FELICITE",
      address: "Bénin, Abomey-Calav",
      imageUrl: ["assets/images/felicite.jpeg"],
      contacts: "98956545"),
  School(
      id: 5,
      nom: "LES SURDOUES",
      address: "Bénin, Abomey-Calav",
      imageUrl: ["assets/images/surdoues.png"],
      contacts: "62656465"),
];