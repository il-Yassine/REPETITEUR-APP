// To parse this JSON data, do
//
//     final teacherModel = teacherModelFromJson(jsonString);

// ignore_for_file: equal_keys_in_map

import 'dart:convert';

import 'package:repetiteur_mobile_app_definitive/core/MODEL/PARENTS/models/communes/commune__model.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/users/users_model.dart';

TeacherModel teacherModelFromJson(String str) => TeacherModel.fromJson(json.decode(str));

String teacherModelToJson(TeacherModel data) => json.encode(data.toJson());

class TeacherModel {
    List<Teachers> data;

    TeacherModel({
        required this.data,
    });

    factory TeacherModel.fromJson(Map<String, dynamic> json) => TeacherModel(
        data: List<Teachers>.from(json["data"].map((x) => Teachers.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Teachers {
    String id;
    String diplomeImageUrl;
    String profilImageUrl;
    String adresse;
    String description;
    String phone;
    String sexe;
    String cycle;
    String etats;
    String evaluation;
    String traitementDossiers;
    String matricule;
    String dateLieuNaissance;
    String situationMatrimoniale;
    String niveauEtude;
    String heureDisponibilite;
    String identite;
    String casierJudiciaire;
    String attestationResidence;
    String grade;
    String status;
    String experience;
    String ecole;
    DateTime createdAt;
    DateTime updatedAt;

    Users user;
    Communes commune;

    Teachers({
        required this.id,
        required this.diplomeImageUrl,
        required this.profilImageUrl,
        required this.adresse,
        required this.description,
        required this.phone,
        required this.sexe,
        required this.cycle,
        required this.etats,
        required this.evaluation,
        required this.traitementDossiers,
        required this.matricule,
        required this.dateLieuNaissance,
        required this.situationMatrimoniale,
        required this.niveauEtude,
        required this.heureDisponibilite,
        required this.identite,
        required this.casierJudiciaire,
        required this.attestationResidence,
        required this.grade,
        required this.status,
        required this.experience,
        required this.ecole,
        required this.createdAt,
        required this.updatedAt,
        required this.user,
        required this.commune,
    });

    factory Teachers.fromJson(Map<String, dynamic> json) => Teachers(
        id: json["id"],
        diplomeImageUrl: json["diplome_imageUrl"],
        profilImageUrl: json["profil_imageUrl"],
        adresse: json["adresse"],
        description: json["description"],
        phone: json["phone"],
        sexe: json["sexe"],
        cycle: json["cycle"],
        etats: json["etats"],
        evaluation: json["evaluation"],
        traitementDossiers: json["traitementDossiers"],
        matricule: json["matricule"],
        dateLieuNaissance: json["dateLieuNaissance"],
        situationMatrimoniale: json["situationMatrimoniale"],
        niveauEtude: json["niveauEtude"],
        heureDisponibilite: json["heureDisponibilite"],
        identite: json["identite"],
        casierJudiciaire: json["casierJudiciaire"],
        attestationResidence: json["attestationResidence"],
        grade: json["grade"],
        status: json["status"],
        experience: json["experience"],
        ecole: json["ecole"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: Users.fromJson(json["user"]),
        commune: Communes.fromJson(json["commune"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "diplome_imageUrl": diplomeImageUrl,
        "profil_imageUrl": profilImageUrl,
        "adresse": adresse,
        "description": description,
        "phone": phone,
        "sexe": sexe,
        "cycle": cycle,
        "etats": etats,
        "evaluation": evaluation,
        "traitementDossiers": traitementDossiers,
        "matricule": matricule,
        "dateLieuNaissance": dateLieuNaissance,
        "situationMatrimoniale": situationMatrimoniale,
        "niveauEtude": niveauEtude,
        "heureDisponibilite": heureDisponibilite,
        "identite": identite,
        "casierJudiciaire": casierJudiciaire,
        "attestationResidence": attestationResidence,
        "grade": grade,
        "status": status,
        "experience": experience,
        "ecole": ecole,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user.toJson(),
        "commune": commune.toJson(),
    };
}
