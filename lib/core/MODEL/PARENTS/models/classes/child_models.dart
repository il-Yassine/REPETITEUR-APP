class Child {
  String id;
  String nom;
  String prenom;
  String phone;

  Child({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.phone,
  });

  // Convert a JSON object into a Child object
  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      id: json['id'] ?? '',
      nom: json['nom'] ?? '',
      prenom: json['prenom'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  // Convert a Child object into a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'phone': phone,
    };
  }
}
  