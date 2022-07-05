// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);
import 'package:meta/meta.dart';
import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));
String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({
    this.id,
    this.nombre1,
    this.nombre2,
    this.apellido1,
    this.apellido2,
    this.cargo,
    this.documento,
    this.dependencia,
    this.correo,
    this.sede,
    this.img,
    this.rol,
    this.estado,
    this.verfi,
  });

  final String? id;
  final String? nombre1;
  final String? nombre2;
  final String? apellido1;
  final String? apellido2;
  final String? cargo;
  final String? documento;
  final String? dependencia;
  final String? correo;
  final String? sede;
  String? img;
  final String? rol;
  final String? estado;
  final String? verfi;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["_id"],
        nombre1: json["nombre1"],
        nombre2: json["nombre2"],
        apellido1: json["apellido1"],
        apellido2: json["apellido2"],
        cargo: json["cargo"],
        documento: json["documento"],
        dependencia: json["dependencia"],
        correo: json["correo"],
        sede: json["sede"],
        img: json["img"],
        rol: json["rol"],
        estado: json["estado"],
        verfi: json["verfi"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre1": nombre1,
        "nombre2": nombre2,
        "apellido1": apellido1,
        "apellido2": apellido2,
        "cargo": cargo,
        "documento": documento,
        "dependencia": dependencia,
        "correo": correo,
        "sede": correo,
        "img": img,
        "rol": rol,
        "estado": estado,
        "verfi": verfi,
      };
}
