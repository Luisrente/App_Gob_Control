// To parse this JSON data, do
//
//     final asistencia = asistenciaFromJson(jsonString);

import 'dart:convert';

Asistencia asistenciaFromJson(String str) =>
    Asistencia.fromJson(json.decode(str));

String asistenciaToJson(Asistencia data) => json.encode(data.toJson());

class Asistencia {
  Asistencia({
    this.id,
    this.nombre,
    this.longitud,
    this.latitud,
    this.distMapBox,
    this.nombre1,
    this.nombre2,
    this.apellido1,
    this.apellido2,
    this.cargo,
    this.documento,
    this.dependencia,
    this.img,
    this.rol,
    this.estado,
    required this.horaInsert,
  });

  String? id;
  String? nombre;
  String? longitud;
  String? latitud;
  String? distMapBox;
  String? nombre1;
  String? nombre2;
  String? apellido1;
  String? apellido2;
  String? cargo;
  String? documento;
  String? dependencia;
  String? img;
  String? rol;
  String? estado;
  DateTime horaInsert;

  factory Asistencia.fromJson(Map<String, dynamic> json) => Asistencia(
        id: json["_id"],
        nombre: json["nombre"],
        longitud: json["longitud"],
        latitud: json["latitud"],
        distMapBox: json["distMapBox"],
        nombre1: json["nombre1"],
        nombre2: json["nombre2"],
        apellido1: json["apellido1"],
        apellido2: json["apellido2"],
        cargo: json["cargo"],
        documento: json["documento"],
        dependencia: json["dependencia"],
        img: json["img"],
        rol: json["rol"],
        estado: json["estado"],
        horaInsert: DateTime.parse(json["horaInsert"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
        "longitud": longitud,
        "latitud": latitud,
        "distMapBox": distMapBox,
        "nombre1": nombre1,
        "nombre2": nombre2,
        "apellido1": apellido1,
        "apellido2": apellido2,
        "cargo": cargo,
        "documento": documento,
        "dependencia": dependencia,
        "img": img,
        "rol": rol,
        "estado": estado,
        "horaInsert": horaInsert.toIso8601String(),
      };
}
