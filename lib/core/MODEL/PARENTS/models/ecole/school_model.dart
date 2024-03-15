// To parse this JSON data, do
//
//     final schoolModel = schoolModelFromJson(jsonString);

import 'dart:convert';

SchoolModel schoolModelFromJson(String str) => SchoolModel.fromJson(json.decode(str));

String schoolModelToJson(SchoolModel data) => json.encode(data.toJson());

class SchoolModel {
    List<School> data;

    SchoolModel({
        required this.data,
    });

    factory SchoolModel.fromJson(Map<String, dynamic> json) => SchoolModel(
        data: List<School>.from(json["data"].map((x) => School.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class School {
    String id;
    String ecoleUrl;
    String name;
    String description;
    String resultat;
    DateTime createdAt;
    DateTime updatedAt;

    School({
        required this.id,
        required this.ecoleUrl,
        required this.name,
        required this.description,
        required this.resultat,
        required this.createdAt,
        required this.updatedAt,
    });

    factory School.fromJson(Map<String, dynamic> json) => School(
        id: json["id"],
        ecoleUrl: json["ecoleUrl"],
        name: json["name"],
        description: json["description"],
        resultat: json["resultat"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "ecoleUrl": ecoleUrl,
        "name": name,
        "description": description,
        "resultat": resultat,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
