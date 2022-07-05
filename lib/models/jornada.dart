import 'dart:convert';

Jornada welcomeFromJson(String str) => Jornada.fromJson(json.decode(str));

String welcomeToJson(Jornada data) => json.encode(data.toJson());

class Jornada {
  Jornada({
    this.sede,
    this.img,
  });

  String? sede;
  String? img;

  factory Jornada.fromJson(Map<String, dynamic> json) => Jornada(
        sede: json["sede"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "sede": sede,
        "img": img,
      };
}
