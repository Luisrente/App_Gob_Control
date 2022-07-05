import 'dart:io';
import 'package:flutter_application_2/models/models.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';



class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();
  
  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  
  Future<Database> initDB() async {
    //Path de donde almaceneremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ercansDB.db');
    // Crear base de datos
    return await openDatabase(path, version: 1, onOpen: (db) {},
    onCreate: (Database db, int version) async {

      await db.execute('''
            CREATE TABLE usuario(
              _id TEXT,
              nombre1 TEXT,
              nombre2 TEXT, 
              apellido1 TEXT,
              apellido2 TEXT,
              cargo TEXT,
              documento TEXT, 
              dependencia TEXT,
              correo TEXT,
              img TEXT, 
              rol TEXT, 
              estado TEXT,
              verfi  TEXT
              )
      ''');

      await db.execute('''
            CREATE TABLE control(
              documentoAdmin TEXT,
              nombreAdmin TEXT,
              apellidoAdmin TEXT, 
              documentoUser TEXT,
              nombreUser TEXT,
              apellidoUser TEXT,
              cargoUser TEXT, 
              dependenciaUser TEXT,
              hora TEXT
              )
      ''');
    });
  }

  Future<int> nuevoScan(Usuario nuevoScan) async {
    final db = await database;
    try {
    final res = await db.insert('usuario', nuevoScan.toJson());
          return res;
    } catch (e) {
      print(e);
    }
    return 1;
  }


   Future<int> nuevocontrol(Control nuevoScan) async {
    final db = await database;
    print(nuevoScan);
    try {
    final res = await db.insert('control', nuevoScan.toJson());
          print(res);
          return res;
    } catch (e) {
      print(e);
    }
    return 1;
  }


   Future <Usuario> getScanById(String id) async {
    print(id);
    Usuario dato= new Usuario();
    try {
      final db = await database;
    final List<Map<String, dynamic >> res = await db.query('usuario', where: 'documento= ?', whereArgs: [id]);
    Usuario dato= new Usuario();
    print(res);
    print('----------ww-w-w--w-w-w-w-w-w-w-w--w-w-w-w-w--w-w-w-w-w-');
    if(res.isNotEmpty){
    dato=Usuario.fromJson(res.first);
    print('--------r-rr-r-r--r-r-r-r');
    print(dato.cargo!);
    print('----we--ew-e-ew-ew-e-w-ew-ew');
    return  dato;
    }else{
    print('----ERROR EN LA CONSULTA ');
    return dato;
    }
    } catch (e) {
      print('Entro al chach ');
      print(e);
    }
    return dato;
  }

 Future<List<Usuario>> getTodosLosScans() async {
    final db = await database;
    final res = await db.query('usuario');
    print('NJD -------------------------------------------');
    print(res);
    print('QQQ -------------------------------------------');
    return res.isNotEmpty ? res.map((s) => Usuario.fromJson(s)).toList() : [];
  }


 Future<List<Control>> getTodosLosControl() async {
    final db = await database;
    final res = await db.query('control');
    print('NJD -------------------------------------------');
    print(res);
    print('QQQ -------------------------------------------');
    return res.isNotEmpty ? res.map((s) => Control.fromJson(s)).toList() : [];
  }

    Future<int> deleteAllScan() async {
    final db = await database;
    final res = await db.rawDelete('''
    DELETE FROM usuario
''');
    return res;
    }
    

   Future<int> dtrucneAllScan() async {
    final db = await database;
    final res = await db.rawDelete('''
    DELETE FROM control
''');



    return res;
  }




  }


  // Future<List<Usuario>> getTodosLosScans() async {
  //   final db = await database;
  //   final res = await db.query('usuario');
  //   //print(res);
  //   return res.isNotEmpty ? res.map((s) => Usuario.fromJson(s)).toList() : [];
  // }

//   Future<List<ScanModel>> getScansPorTipo(String tipo) async {
//     final db = await database;
//     final res = await db.rawQuery('''
//       SELECT * FROM Scans WHERE tipo='$tipo'
//     ''');
//     // print(res);
//     return res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];
//   }

//   Future<int> updateScan(ScanModel nuevoScan) async {
//     final db = await database;
//     final res = await db.update('Scans', nuevoScan.toJson(),
//         where: 'id=?', whereArgs: [nuevoScan.id]);
//     return res;
//   }

//   Future<int> deleteScan(int id) async {
//     final db = await database;
//     final res = await db.delete('Scans', where: 'id=?', whereArgs: [id]);
//     return res;
//   }

//   Future<int> deleteAllScan() async {
//     final db = await database;
//     final res = await db.rawDelete('''
//     DELETE FROM Scans
// ''');
//     return res;
//   }
// }
