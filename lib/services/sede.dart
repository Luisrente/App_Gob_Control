import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/models.dart';
import 'package:flutter_application_2/models/sederesponse.dart';
import 'package:flutter_application_2/services/services.dart';
import 'package:http/http.dart' as http;

class SedeService extends ChangeNotifier {
  SedeService() {
    listsede();
  }

  Future<List<String>> listsede() async {
    List<String> nombre = [];
    List<Sede> sedes = [];
    Sede sede = Sede();
    try {
      final uri = Uri.parse('https://apigob.herokuapp.com/api/sede/sede');
      final resp =
          await http.get(uri, headers: {'Content-Type': 'application/json'});
      if (resp.statusCode == 200) {
        // sedeResponseFromJson(resp.body);
        // log('${resp.body}');

        final sedeResponse = sedeResponseFromJson(resp.body);
        sedes = sedeResponse.sede;
        sedes.forEach((element) {
          element.nombre;
          nombre.add(element.nombre!);
        });
        log('---------${nombre}');

        return nombre;
      }
    } catch (e) {
      log('${e}');

      NotificationsService.showSnackbar("Comunicarse con el admin loadcard ");
    }
    return nombre;
  }
}
