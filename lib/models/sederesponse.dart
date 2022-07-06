// To parse this JSON data, do
//
//     final sedeResponse = sedeResponseFromJson(jsonString);

import 'dart:convert';
import 'package:flutter_application_2/models/models.dart';

SedeResponse sedeResponseFromJson(String str) =>
    SedeResponse.fromJson(json.decode(str));

String sedeResponseToJson(SedeResponse data) => json.encode(data.toJson());

class SedeResponse {
  SedeResponse({
    required this.sede,
  });

  List<Sede> sede;

  factory SedeResponse.fromJson(Map<String, dynamic> json) => SedeResponse(
        sede: List<Sede>.from(json["sede"].map((x) => Sede.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sede": List<dynamic>.from(sede.map((x) => x.toJson())),
      };
}
