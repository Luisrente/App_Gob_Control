import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:flutter_application_2/services/services.dart';

import '../models/models.dart';

// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
// class AuthService {
  // final storage = new FlutterSecureStorage();
  List<Usuario> usuarios = [];
  late Usuario usuario;

  final prefe = UserPrefe();

  bool _autenticando = false;

  bool get autenticando => this._autenticando;

  set autenticando(bool valor) {
    this._autenticando = valor;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    print(email);
    print(password);
    final data = {'correo': email, 'password': password};
    log('--->${data}');
    autenticando = true;
    notifyListeners();

    try {
      final uri = Uri.parse('https://apigob.herokuapp.com/api/auth/login');
      final resp = await http.post(uri,
          body: jsonEncode(data),
          headers: {'Content-Type': 'application/json'});
      log('--->${resp.statusCode}');
      autenticando = false;

      if (resp.statusCode == 200) {
        final loginResponse = loginResponseFromJson(resp.body);
        usuario = loginResponse.usuario;
        await prefe.logout();
        await prefe.setUserInfo(usuario);
        // datosbase();
        return true;
      } else {
        // final respBody = jsonDecode(resp.body);
        // NotificationsService.showSnackbar(respBody['msg']);
        return false;
      }
    } catch (e) {
      log('${e}');
      return false;
      // NotificationsService.showSnackbar("Comunicarse con el admin ");
    }
  }

  Future<bool> password(String password) async {
    final data = {'password': password};
    final Usuario user = await prefe.getUserInfo();
    log('tkykykrrrrrrrrrkyky');
    autenticando = true;

    try {
      final uri =
          Uri.parse('https://apigob.herokuapp.com/api/usuarios/${user.id}');
      final resp = await http.put(uri,
          body: jsonEncode(data),
          headers: {'Content-Type': 'application/json'});
      autenticando = false;

      log('tkykykrrrrryyyyretu0000000rrrrkyky');
      log('--->${resp.statusCode}');
      log('tkykykrrrr77777rrrrrkyky');

      int y = resp.statusCode;
      log('${y}');

      if (y == 200) {
        log('yyyyyyyyyy');
        log('--->${resp.statusCode}');

        return true;
        // await this._guardarToken(loginResponse.token);
      } else {
        final respBody = jsonDecode(resp.body);
        NotificationsService.showSnackbar(respBody['msg']);
        return false;
      }
    } catch (e) {
      print(e);
      NotificationsService.showSnackbar("Comunicarse con el admin ");
    }
    return false;
  }

  Future<bool> register(dato) async {
    // final data = {'password': password};
    autenticando = true;
    log('${dato}');

    // final data = {
    //   "nombre1": "luis",
    //   "nombre2": "",
    //   "apellido1": "Renteria",
    //   "apellido2": "Martineez",
    //   "cargo": "Secretario",
    //   "documento": "12345678",
    //   "dependencia": "Visitante",
    //   "correo": "visyyi@gmail.com",
    //   "password": "987654321",
    //   "sede": "Visitante",
    //   "img": "",
    //   "rol": "ADMIN_ROLE",
    //   "estado": false,
    //   "verfi": false
    // };

    try {
      final uri = Uri.parse('https://apigob.herokuapp.com/api/usuarios');
      final resp = await http.post(uri,
          body: jsonEncode(dato),
          headers: {'Content-Type': 'application/json'});

      autenticando = false;

      int y = resp.statusCode;
      log('------>${resp.body}');

      if (y == 200) {
        final loginResponse = loginResponseFromJson(resp.body);
        usuario = loginResponse.usuario;

        log('---------->${y}');

        await prefe.logout();
        await prefe.setUserInfo(usuario);

        return true;
        // await this._guardarToken(loginResponse.token);
      } else {
        final respBody = jsonDecode(resp.body);
        NotificationsService.showSnackbar(respBody['msg']);
        return false;
      }
    } catch (e) {
      print(e);
      // NotificationsService.showSnackbar("Comunicarse con el admin ");
    }
    return false;
  }

  Future<String> colorTheme(String id) async {
    final data = {'color': id};
    try {
      final uri = Uri.parse('https://apigob.herokuapp.com/api/color');
      final resp = await http.post(uri,
          body: jsonEncode(data),
          headers: {'Content-Type': 'application/json'});
      print('paso');
      if (resp.statusCode == 200) {
        print('entro');
        return '1';
        // await this._guardarToken(loginResponse.token);
      } else {
        final respBody = jsonDecode(resp.body);
        NotificationsService.showSnackbar(respBody['msg']);
        return '';
      }
    } catch (e) {
      NotificationsService.showSnackbar("Error color ");
    }
    return '';
  }

  Future datosbase() async {
    // isLoading = true;
    // notifyListeners();
    Usuario dato2 = Usuario();
    try {
      final uri = Uri.parse('https://apigob.herokuapp.com/api/usuarios');
      final resp =
          await http.get(uri, headers: {'Content-Type': 'application/json'});

      if (resp.statusCode == 200) {
        print(resp);
        print('paso por el metodo base(dfdfdfdfd)');
        final loginResponse = getsUsuarioFromJson(resp.body);
        usuarios = loginResponse.usuario;
        print(usuarios[0]);
        for (var i = 0; i < usuarios.length - 1; i++) {
          // final s =  await DBProvider.db.nuevoScan(usuarios[i]);
        }
        // final s =  await DBProvider.db.getTodosLosScans();
        // print(s.length);
      }
    } catch (e) {
      // NotificationsService.showSnackbar("Comunicarse con admin base local ");
    }
  }

  // Future logunt() async {
  //   await storage.delete(key: 'token');
  //   await storage.delete(key: 'id');
  //   // await DBProvider.db.deleteAllScan();
  //   return;
  // }

  // Future<String> readToken() async {
  //   return await storage.read(key: 'token') ?? '';
  // }

  // Future<String> readId() async {
  //   return await storage.read(key: 'id') ?? '';
  // }

  // Future<String> readData() async {
  //   return await storage.read(key: 'email') ?? '';
  // }

}
