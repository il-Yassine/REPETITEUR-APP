// To parse this JSON data, do
//
//     final tarificationModel = tarificationModelFromJson(jsonString);

import 'dart:convert';

import 'package:repetiteur_mobile_app_definitive/core/MODEL/PARENTS/models/classes/classes_model.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/PARENTS/models/classes/repetiteur_model.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/PARENTS/models/matieres/matieres_model.dart';

TarificationModel tarificationModelFromJson(String str) =>
    TarificationModel.fromJson(json.decode(str));

String tarificationModelToJson(TarificationModel data) =>
    json.encode(data.toJson());

class TarificationModel {
  List<Tarification> data;

  TarificationModel({
    required this.data,
  });

  factory TarificationModel.fromJson(Map<String, dynamic> json) =>
      TarificationModel(
        data: List<Tarification>.from(
            json["data"].map((x) => Tarification.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Tarification {
  String id;
  String prix;
  Matieres matiere;
  Classes classe;
  Repetiteur repetiteur;
  DateTime createdAt;
  DateTime updatedAt;

  Tarification({
    required this.id,
    required this.prix,
    required this.matiere,
    required this.classe,
    required this.repetiteur,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Tarification.fromJson(Map<String, dynamic> json) => Tarification(
        id: json["id"],
        prix: json["prix"],
        matiere: Matieres.fromJson(json["matiere"]),
        classe: Classes.fromJson(json["classe"]),
        repetiteur: json["repetiteur"] != null
            ? Repetiteur.fromJson(json["repetiteur"])
            : Repetiteur(id: '', name: '', matricule: ''),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "prix": prix,
        "matiere": matiere.toJson(),
        "classe": classe.toJson(),
        "repetiteur": repetiteur.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
