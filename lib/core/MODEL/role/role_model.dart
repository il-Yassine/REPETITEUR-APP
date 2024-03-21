// To parse this JSON data, do
//
//     final roleModel = roleModelFromJson(jsonString);

import 'dart:convert';

RoleModel roleModelFromJson(String str) => RoleModel.fromJson(json.decode(str));

String roleModelToJson(RoleModel data) => json.encode(data.toJson());

class RoleModel {
    List<Role> data;

    RoleModel({
        required this.data,
    });

    factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
        data: List<Role>.from(json["data"].map((x) => Role.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Role {
    String id;
    String name;
    DateTime createdAt;
    DateTime updatedAt;

    Role({
        required this.id,
        required this.name,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Role.fromJson(Map<String, dynamic> json) => Role(
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
