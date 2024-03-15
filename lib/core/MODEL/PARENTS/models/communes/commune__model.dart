// To parse this JSON data, do
//
//     final CommunesModel = CommunesModelFromJson(jsonString);

import 'dart:convert';

CommunesModel CommunesModelFromJson(String str) => CommunesModel.fromJson(json.decode(str));

String CommunesModelToJson(CommunesModel data) => json.encode(data.toJson());

class CommunesModel {
    List<Communes> data;

    CommunesModel({
        required this.data,
    });

    factory CommunesModel.fromJson(Map<String, dynamic> json) => CommunesModel(
        data: List<Communes>.from(json["data"].map((x) => Communes.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Communes {
    String id;
    String name;
    DateTime createdAt;
    DateTime updatedAt;

    Communes({
        required this.id,
        required this.name,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Communes.fromJson(Map<String, dynamic> json) => Communes(
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
