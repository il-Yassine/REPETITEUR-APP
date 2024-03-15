class Repetiteur {
  final String id;
  final String matricule;
  final String name;

  Repetiteur({
    required this.id,
    required this.matricule,
    required this.name,
  });

  factory Repetiteur.fromJson(Map<String, dynamic> json) {
    return Repetiteur(
      id: json['id'] ?? '', 
      matricule: json['matricule'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'matricule': matricule,
      'name': name,
    };
  }
}
