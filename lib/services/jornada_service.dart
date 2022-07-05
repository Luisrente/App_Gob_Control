import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_application_2/models/asistenciaResponse.dart';
import 'package:flutter_application_2/services/services.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../models/models.dart';

// class JornadaServices {
class JornadaServices extends ChangeNotifier {
  Jornada selectJornada = Jornada();
  File? newPictureFile;
  Usuario local = Usuario();
  final prefe = UserPrefe();
  List<Asistencia> listasistencia = [];

  // Usuario local = Usuario();

  JornadaServices() {}

  void updateSelectedJornadaImg(String path) {
    selectJornada.img = path;
    newPictureFile = File.fromUri(Uri(path: path));
  }

  Future<List<Asistencia>> asistenciaMes(month) async {
    local = await prefe.getUserInfo();
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);

    final data = {
      "inicio": '${now.year}-${month}-01T00:00:00.000Z',
      "fin": '${now.year}-${month}-31T23:59:59.999Z',
      "documento": local.documento
    };
    // "documento": 12345678
    log('--mes ->${month}');
    // autenticando = true;
    // notifyListeners();
    try {
      final uri = Uri.parse('https://apigob.herokuapp.com/api/asis/mes');
      final resp = await http.post(uri,
          body: jsonEncode(data),
          headers: {'Content-Type': 'application/json'});
      log('--->${resp.statusCode}');
      if (resp.statusCode == 200) {
        log('---rrrrrrrrrr>${resp.body}');
        final asitenciarespondse = asistenciaResponseFromJson(resp.body);
        List<Asistencia> listasistencia;
        listasistencia = asitenciarespondse.asistencia;

        return listasistencia;
      } else {
        return listasistencia;
        // NotificationsService.showSnackbar(respBody['msg']);
      }
    } catch (e) {
      log('${e}');
      NotificationsService.showSnackbar("Error 404 month");
    }
    return listasistencia;
  }

  Future<String?> uploadImageAsist(String? path, String id) async {
    Usuario dato1 = Usuario();
    dato1 = await prefe.getUserInfo();
    newPictureFile = File.fromUri(Uri(path: path));
    if (this.newPictureFile == null) return null;

    // notifyListeners();
    final url =
        Uri.parse('https://apigob.herokuapp.com/api/uploads/asistencias/${id}');
    final imageUploadRequest = http.MultipartRequest('PUT', url);

    final file =
        await http.MultipartFile.fromPath('archivo', newPictureFile!.path);
    imageUploadRequest.files.add(file);
    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal');
      print(resp.body);
      return null;
    }
    notifyListeners();
    this.newPictureFile = null;
    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];
  }
}
