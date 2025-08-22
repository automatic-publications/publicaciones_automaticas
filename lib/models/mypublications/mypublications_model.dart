import 'dart:convert';

List<MyPublicationsModel> publicacionesFromJson(String str) =>
    List<MyPublicationsModel>.from(json.decode(str).map((x) => MyPublicationsModel.fromMap(x)));

String publicacionesToJson(List<MyPublicationsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class MyPublicationsModel {
  final int id;
  final String descripcion;
  final String? imagenUrl;
  final String estado;

  MyPublicationsModel({
    required this.id,
    required this.descripcion,
    this.imagenUrl,
    required this.estado,
  });

  factory MyPublicationsModel.fromJson(String str) =>
      MyPublicationsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MyPublicationsModel.fromMap(Map<String, dynamic> json) => MyPublicationsModel(
        id: json["id"],
        descripcion: json["descripcion"] ?? "",
        imagenUrl: json["imagenUrl"], 
        estado: json["estado"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "descripcion": descripcion,
        "imagenUrl": imagenUrl,
        "estado": estado,
      };
}
