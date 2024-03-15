// To parse this JSON data, do
//
//     final classesModel = classesModelFromJson(jsonString);

import 'dart:convert';

ClassesModel classesModelFromJson(String str) => ClassesModel.fromJson(json.decode(str));

String classesModelToJson(ClassesModel data) => json.encode(data.toJson());

class ClassesModel {
    List<Classes> data;

    ClassesModel({
        required this.data,
    });

    factory ClassesModel.fromJson(Map<String, dynamic> json) => ClassesModel(
        data: List<Classes>.from(json["data"].map((x) => Classes.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Classes {
    String id;
    String name;
    DateTime createdAt;
    DateTime updatedAt;

    Classes({
        required this.id,
        required this.name,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Classes.fromJson(Map<String, dynamic> json) => Classes(
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
