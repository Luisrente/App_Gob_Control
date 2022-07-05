// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'package:flutter_application_2/models/models.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.usuario,
    this.token,
  });

  final Usuario usuario;
  final String? token;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        usuario: Usuario.fromJson(json["usuario"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "usuario": usuario.toJson(),
        "token": token,
      };
}
