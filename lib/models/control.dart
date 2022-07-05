// To parse this JSON data, do
//
//     final control = controlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Control controlFromJson(String str) => Control.fromJson(json.decode(str));

String controlToJson(Control data) => json.encode(data.toJson());

class Control {
  Control({
    this.documentoAdmin,
    this.nombreAdmin,
    this.apellidoAdmin,
    this.documentoUser,
    this.nombreUser,
    this.apellidoUser,
    this.cargoUser,
    this.dependenciaUser,
    this.hora,
  });

  final String? documentoAdmin;
  final String? nombreAdmin;
  final String? apellidoAdmin;
  final String? documentoUser;
  final String? nombreUser;
  final String? apellidoUser;
  final String? cargoUser;
  final String? dependenciaUser;
  final String? hora;

  factory Control.fromJson(Map<String, dynamic> json) => Control(
        documentoAdmin: json["documentoAdmin"],
        nombreAdmin: json["nombreAdmin"],
        apellidoAdmin: json["apellidoAdmin"],
        documentoUser: json["documentoUser"],
        nombreUser: json["nombreUser"],
        apellidoUser: json["apellidoUser"],
        cargoUser: json["cargoUser"],
        dependenciaUser: json["dependenciaUser"],
        hora: json["hora"],
      );

  Map<String, dynamic> toJson() => {
        "documentoAdmin": documentoAdmin,
        "nombreAdmin": nombreAdmin,
        "apellidoAdmin": apellidoAdmin,
        "documentoUser": documentoUser,
        "nombreUser": nombreUser,
        "apellidoUser": apellidoUser,
        "cargoUser": cargoUser,
        "dependenciaUser": dependenciaUser,
        "hora": hora,
      };
}
