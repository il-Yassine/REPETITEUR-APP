// To parse this JSON data, do
//
//     final matiereModel = matiereModelFromJson(jsonString);

import 'dart:convert';

MatiereModel matiereModelFromJson(String str) => MatiereModel.fromJson(json.decode(str));

String matiereModelToJson(MatiereModel data) => json.encode(data.toJson());

class MatiereModel {
    List<Matieres> data;

    MatiereModel({
        required this.data,
    });

    factory MatiereModel.fromJson(Map<String, dynamic> json) => MatiereModel(
        data: List<Matieres>.from(json["data"].map((x) => Matieres.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Matieres {
    String id;
    String name;
    DateTime createdAt;
    DateTime updatedAt;

    Matieres({
        required this.id,
        required this.name,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Matieres.fromJson(Map<String, dynamic> json) => Matieres(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
