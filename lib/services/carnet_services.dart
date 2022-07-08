import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/provider/provider.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_application_2/services/services.dart';

import '../models/models.dart';

// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_application_2/shared_prefe/preferencias_user.dart';
// import 'package:gob_cordoba/provider/provider.dart';
// import 'package:gob_cordoba/models/models.dart';
// import 'package:gob_cordoba/services/services.dart';

// class CarnetService {
class CarnetService extends ChangeNotifier {
  List<Usuario> usuarios = [];
  Usuario usuario = Usuario();
  Usuario usualiorSelect = Usuario();
  Usuario selectedProduct = Usuario();
  final prefe = UserPrefe();
  File? newPictureFile;

  bool isLoading = false;
  bool isSaving = false;

  CarnetService() {
    this.loadCartUser();
  }

  // Future<String> readData() async {
  //   return await storage.read(key: 'data') ?? '';
  // }

  Future<Usuario> loadCartUser() async {
    Usuario local = Usuario();
    local = await prefe.getUserInfo();
    try {
      final uri = Uri.parse(
          'https://apigob.herokuapp.com/api/usuarios/${local.documento}');
      final resp =
          await http.get(uri, headers: {'Content-Type': 'application/json'});
      await prefe.getUserInfo();

      if (resp.statusCode == 200) {
        final loginResponse = loginResponseFromJson(resp.body);
        usuario = loginResponse.usuario;
        selectedProduct = usuario;
        selectedProduct.img = usuario.img;
        await prefe.setUserInfo(usuario);
        local = await prefe.getUserInfo();
        return usuario;
      } else {
        local = await prefe.getUserInfo();
        return local;
      }
    } catch (e) {
      local = await prefe.getUserInfo();
      return local;
      // NotificationsService.showSnackbar("Comunicarse con el admin loadcard ");
    }
  }

  Future<Usuario> loadCarstAdmin(String id) async {
    isLoading = true;
    notifyListeners();
    Usuario dato1 = Usuario();
    // datosbase( );
    try {
      final uri = Uri.parse('https://apigob.herokuapp.com/api/usuarios/${id}');
      final resp =
          await http.get(uri, headers: {'Content-Type': 'application/json'});
      print('paso');
      if (resp.statusCode == 200) {
        final loginResponse = loginResponseFromJson(resp.body);
        usuario = loginResponse.usuario;
        usualiorSelect = usuario;
        return usuario;
      } else {}
    } catch (e) {
      final Usuario scans = await DBProvider.db.getScanById(id);
      if (scans.apellido1 == null) {
        print('null');
      } else {
        usualiorSelect = scans;
        return scans;
      }
    }
    return dato1;
  }

  // Future<bool> loadCarstAdmin(String id) async {
  //   isLoading = true;
  //   // notifyListeners();
  //   Usuario dato1 = Usuario();
  //   // datosbase( );
  //   try {
  //     final uri = Uri.parse('https://apigob.herokuapp.com/api/usuarios/${id}');
  //     final resp =
  //         await http.get(uri, headers: {'Content-Type': 'application/json'});
  //     print('paso');
  //     if (resp.statusCode == 200) {
  //       final loginResponse = loginResponseFromJson(resp.body);
  //       usuario = loginResponse.usuario;
  //       usualiorSelect = usuario;
  //       return true;
  //     } else {}
  //   } catch (e) {
  //     return false;

  //     // final Usuario scans = await DBProvider.db.getScanById(id);
  //     // if (scans.apellido1 == null) {
  //     //   print('null');
  //     // } else {
  //     //   usualiorSelect = scans;
  //     //   return scans;
  //     // }
  //   }
  //   return false;
  // }

  // Future loadControlAdmin(Control control) async {
  //   isLoading = true;
  //   notifyListeners();
  //   Usuario dato1 = Usuario();
  //   try {
  //     final uri = Uri.parse('https://apigob.herokuapp.com/api/control');
  //     final resp = await http.post(uri,
  //         body: jsonEncode(control),
  //         headers: {'Content-Type': 'application/json'});
  //     await cargaControl();
  //     print(resp.statusCode);
  //   } catch (e) {
  //     await DBProvider.db.nuevocontrol(control);
  //   }
  //   return dato1;
  // }

  // cargaControl() async {
  //   List<Control> control = [];
  //   control = await DBProvider.db.getTodosLosControl();
  //   if (control.length != 0) {
  //     for (var i = 0; i < control.length; i++) {
  //       try {
  //         final uri = Uri.parse('https://apigob.herokuapp.com/api/control');
  //         final resp = await http.post(uri,
  //             body: jsonEncode(control[i]),
  //             headers: {'Content-Type': 'application/json'});
  //       } catch (e) {
  //         print(e);
  //       }
  //     }
  //     await DBProvider.db.dtrucneAllScan();
  //   }
  // }

  // datosbase() async {
  //   isLoading = true;
  //   notifyListeners();
  //   Usuario dato2 = Usuario();
  //   try {
  //     final uri = Uri.parse('https://apigob.herokuapp.com/api/usuarios');
  //     final resp =
  //         await http.get(uri, headers: {'Content-Type': 'application/json'});

  //     if (resp.statusCode == 200) {
  //       print(resp);
  //       print('paso por el metodo base(dfdfdfdfd)');
  //       final loginResponse = getsUsuarioFromJson(resp.body);
  //       usuarios = loginResponse.usuario;
  //       print(usuarios[0]);
  //       for (var i = 0; i < usuarios.length - 1; i++) {
  //         final s = await DBProvider.db.nuevoScan(usuarios[i]);
  //       }
  //       final s = await DBProvider.db.getTodosLosScans();
  //       print(s.length);
  //     }
  //   } catch (e) {
  //     NotificationsService.showSnackbar("Comunicarse con admin base local ");
  //   }
  // }

  Future<bool> uploadImage(String? path) async {
    try {
      Usuario dato1 = Usuario();
      dato1 = await prefe.getUserInfo();
      this.selectedProduct.img = path;
      this.newPictureFile = File.fromUri(Uri(path: path));
      log('-----paso1--->------->');
      // if (this.newPictureFile == null) return false;
      // this.isSaving = true;

      log('-----paso--2->------->');

      // notifyListeners();
      final url = Uri.parse(
          'https://apigob.herokuapp.com/api/uploads/usuarios/${dato1.id}');
      final imageUploadRequest = http.MultipartRequest('PUT', url);
      log('-----paso--->---3---->');

      final file =
          await http.MultipartFile.fromPath('archivo', newPictureFile!.path);
      imageUploadRequest.files.add(file);
      final streamResponse = await imageUploadRequest.send();
      final resp = await http.Response.fromStream(streamResponse);
      log('-----paso--->---4---->');

      log('$resp');
      if (resp.statusCode != 200 && resp.statusCode != 201) {
        log('-----paso--->--5----->');

        print('Algo salio mal');
        NotificationsService.showSnackbar("Error en el cargue de la imagen");
        print(resp.body);
        return false;
      } else {
        return true;
      }

      notifyListeners();
      this.newPictureFile = null;
      // final decodedData = json.decode(resp.body);
      // return decodedData['secure_url'];
    } catch (e) {
      log('$e');
    }
    return false;

    // Usuario dato1 = Usuario();
    // dato1 = await prefe.getUserInfo();
    // this.selectedProduct.img = path;
    // this.newPictureFile = File.fromUri(Uri(path: path));
    // if (this.newPictureFile == null) return false;
    // this.isSaving = true;
    // // notifyListeners();
    // final url = Uri.parse(
    //     'https://apigob.herokuapp.com/api/uploads/usuarios/${dato1.id}');
    // final imageUploadRequest = http.MultipartRequest('PUT', url);
    // final file =
    //     await http.MultipartFile.fromPath('archivo', newPictureFile!.path);
    // imageUploadRequest.files.add(file);
    // final streamResponse = await imageUploadRequest.send();
    // final resp = await http.Response.fromStream(streamResponse);
    // log('$resp');
    // if (resp.statusCode != 200 && resp.statusCode != 201) {
    //   print('Algo salio mal');
    //   NotificationsService.showSnackbar("Error en el cargue de la imagen");
    //   print(resp.body);
    //   return false;
    // } else {}
    // notifyListeners();
    // this.newPictureFile = null;
    // final decodedData = json.decode(resp.body);
    // return decodedData['secure_url'];
  }

  // void updateSelectedProductImage(String? path) {
  //   this.selectedProduct.img = path;
  //   this.newPictureFile = File.fromUri(Uri(path: path));
  //   notifyListeners();
  // }

}

  
  // Future saveOrCreateProduct( Product product) async {
  //   isSaving = true;
  //   notifyListeners();

  //   if ( product.id == null){
  //     await this.createProduct(product);
  //   }else{
  //     await this.updateProduct(product); 
  //   }
  //   isSaving= false;
  //   notifyListeners();
  // }

  // Future<String> updateProduct(Product product ) async{
  //   final url = Uri.https( _baseUrl, 'Products/${product.id}.json');
  //   final resp = await http.put(url, body: product.toJson()  );
  //   final decodedData= resp.body;
  //    final index= this.products.indexWhere((element)=> element.id == product.id);
  //    this.products[index]= product;
  //    return product.id!;
  // }

  //  Future<String> createProduct( Usuario product ) async{
  //   final url = Uri.https( _baseUrl, 'Usuario.json');
  //   final resp = await http.post(url, body: product.toJson());
  //   final decodedData= json.decode(resp.body);
  //   //product.id= decodedData['name'];
  //   // this.products.add(product);
  //   print('jjjyjy');
  //   print(decodedData);
  //   print('jjtjtjjtjtj');
  //   return product.email!;
  // }

  // void updateSelectedProductImage( String path){
    
  //   this.selectedProduct.picture = path;
  //   this.newPictureFile = File.fromUri(Uri(path: path));

  //   notifyListeners();
  // }

  // Future<String?>uploadImage() async {
  //   if( this.newPictureFile == null) return null;

  //   this.isSaving= true;
  //    notifyListeners();
  //    final url = Uri.parse('https://api.cloudinary.com/v1_1/dve1nfb9j/image/upload?upload_preset=yqeniftu');
  //    final imageUploadRequest = http.MultipartRequest('POST',url);
  //    final file= await http.MultipartFile.fromPath('file', newPictureFile!.path);
  //    imageUploadRequest.files.add(file);
  //    final streamResponse= await imageUploadRequest.send();
  //    final resp = await http.Response.fromStream(streamResponse);
  //   if(resp.statusCode != 200 && resp.statusCode != 201){
  //     print('Algo salio mal');
  //     print(resp.body);
  //     return null;
  //   }
  //   this.newPictureFile=null;
  //   final decodedData = json.decode(resp.body);
  //   return decodedData['secure_url'];

  // }
