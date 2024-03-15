import 'package:repetiteur_mobile_app_definitive/core/MODEL/PARENTS/models/classes/child_models.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/PARENTS/models/classes/repetiteur_model.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/PARENTS/models/tarifications/tarification_model.dart';

class Demande {
  final String id;
  final String status;
  final String? motif;
  final Child child;
  final Tarification tarification;
  final Repetiteur repetiteur;

  Demande({
    required this.id,
    required this.status,
    this.motif,
    required this.child,
    required this.tarification,
    required this.repetiteur,
  });

  factory Demande.fromJson(Map<String, dynamic> json) {
    return Demande(
      id: json['id'] ?? '', // Assurez-vous de traiter les valeurs null ici
      status: json['status'] ?? '',
      motif: json['motif'], // Peut être null, car c'est un champ nullable
      child: Child.fromJson(json['enfants'] ?? {}), // Assurez-vous de traiter les valeurs null ici
      tarification: Tarification.fromJson(json['tarification'] ?? {}), // Assurez-vous de traiter les valeurs null ici
      repetiteur: Repetiteur.fromJson(json['repetiteur'] ?? {}), // Assurez-vous de traiter les valeurs null ici
    );
  }
}
