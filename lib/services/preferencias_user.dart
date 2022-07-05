import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/models.dart';

// class UserPrefe {
class UserPrefe extends ChangeNotifier {
  SharedPreferences? _prefs;
  String prefClave = 'usuario'; //clave
  // late Usuario dato1 = Usuario();

  Future<UserPrefe> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  // Usuario userget(Usuario vale) {
  //   // try {
  //   //   String? userStr = _prefs?.getString(prefClave);
  //   //   if (userStr == null) {
  //   //     // return null;
  //   //   }
  //   //   Map<String, dynamic> userMap = jsonDecode(userStr);
  //   //   return Usuario.fromJson(userMap);
  //   // } catch (e) {
  //   //   print(e);
  //   // }

  //   return vale;
  // }

  // set userset(Usuario value) {
  //   final r = _prefs?.setString(prefClave, jsonEncode(value.toJson()));
  //   r!.then((e) {
  //     log("--->$e");
  //   });
  // }

  Future<void> setUserInfo(Usuario value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? r = await prefs.setString(prefClave, jsonEncode(value.toJson()));
    print(r);
  }

  Future<Usuario> getUserInfo() async {
    try {} catch (e) {}
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userStr = await prefs.getString(prefClave);
    Map<String, dynamic> userMap = jsonDecode(userStr!);
    final Usuario user = Usuario.fromJson(userMap);
    return user;
  }

  Future<bool> loggin() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userStr = await prefs.getString('usuario');
      if (userStr != null) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  logout() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final bool userStr = await prefs.remove('usuario');
    } catch (e) {}
  }
}
