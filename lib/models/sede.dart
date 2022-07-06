// To parse this JSON data, do
//
//     final sede = sedeFromJson(jsonString);

import 'dart:convert';

Sede sedeFromJson(String str) => Sede.fromJson(json.decode(str));

String sedeToJson(Sede data) => json.encode(data.toJson());

class Sede {
  Sede({
    this.id,
    this.nombre,
    this.distancia,
    this.longitud,
    this.latitud,
  });

  String? id;
  String? nombre;
  int? distancia;
  double? longitud;
  double? latitud;

  factory Sede.fromJson(Map<String, dynamic> json) => Sede(
        id: json["_id"],
        nombre: json["nombre"],
        distancia: json["distancia"],
        longitud: json["longitud"],
        latitud: json["latitud"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
        "distancia": distancia,
        "longitud": longitud,
        "latitud": latitud,
      };
}
