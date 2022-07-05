import 'package:flutter_application_2/models/models.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

GetsUsuario getsUsuarioFromJson(String str) =>
    GetsUsuario.fromJson(json.decode(str));

String getsUsuarioToJson(GetsUsuario data) => json.encode(data.toJson());

class GetsUsuario {
  GetsUsuario({
    required this.usuario,
  });
  final List<Usuario> usuario;
  factory GetsUsuario.fromJson(Map<String, dynamic> json) => GetsUsuario(
        usuario:
            List<Usuario>.from(json["usuario"].map((x) => Usuario.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "usuario": List<dynamic>.from(usuario.map((x) => x.toJson())),
      };
}
