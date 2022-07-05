// To parse this JSON data, do
//
//     final asistencia = asistenciaFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_application_2/models/models.dart';

AsistenciaResnpose asistenciaResponseFromJson(String str) =>
    AsistenciaResnpose.fromJson(json.decode(str));

String asistenciaResponseToJson(AsistenciaResnpose data) =>
    json.encode(data.toJson());

class AsistenciaResnpose {
  AsistenciaResnpose({
    required this.asistencia,
  });

  List<Asistencia> asistencia;

  factory AsistenciaResnpose.fromJson(Map<String, dynamic> json) =>
      AsistenciaResnpose(
        asistencia: List<Asistencia>.from(
            json["asistencia"].map((x) => Asistencia.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "asistencia": List<dynamic>.from(asistencia.map((x) => x.toJson())),
      };
}
