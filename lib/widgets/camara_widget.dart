// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:developer';

// // late List<CameraDescription> _cameras;

// // Future<void> main() async {
// //   WidgetsFlutterBinding.ensureInitialized();

// //   _cameras = await availableCameras();
// //   runApp(const CameraApp());
// // }

// /// CameraApp is the Main Application.
// class CameraApps extends StatefulWidget {
//   /// Default Constructor
//   ///
//   final List<CameraDescription> camera;

//   const CameraApps({Key? key, required this.camera}) : super(key: key);

//   @override
//   State<CameraApps> createState() => CameraAppsState();
// }

// class CameraAppsState extends State<CameraApps> {
//   late CameraController controller;

//   late Future<void> initializeControllerFuture;

//   @override
//   void initState() {
//     super.initState();
//     controller = CameraController(widget.camera[1], ResolutionPreset.max);
//     // controller1 = CameraController(widget.camera[1], ResolutionPreset.max);
//     // controller = CameraController(camera[1], ResolutionPreset.max);
//     // _initializeControllerFuture = controller.initialize();

//     initializeControllerFuture = controller.initialize().then((_) {
//       // initializeControllerFuture = controller.initialize();
//       if (!mounted) {
//         return;
//       }
//       setState(() {});
//     }).catchError((Object e) {
//       if (e is CameraException) {
//         switch (e.code) {
//           case 'CameraAccessDenied':
//             print('User denied camera access.');
//             break;
//           default:
//             print('Handle other errors.');
//             break;
//         }
//       }
//     });
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!controller.value.isInitialized) {
//       return Container();
//     }

//     return FutureBuilder<void>(
//       future: initializeControllerFuture,
//       builder: (context, snapshot) {
//         print('paso por aqui');
//         if (snapshot.connectionState == ConnectionState.done) {
//           // Si el Future está completo, muestra la vista previa
//           return Column(
//             children: [
//               ClipRRect(
//                   child: ClipRRect(
//                       borderRadius: BorderRadius.circular(15.0),
//                       child: Container(
//                           width: MediaQuery.of(context).size.width * 0.6,
//                           height: MediaQuery.of(context).size.height * 0.35,
//                           child: CameraPreview(controller)))),
//               TextButton(
//                 child: Icon(Icons.camera_alt),
//                 // Agrega un callback onPressed
//                 onPressed: () async {
//                   print('jgjgjgjgjjgjgjgj');
//                   // Toma la foto en un bloque de try / catch. Si algo sale mal,
//                   // atrapa el error.
//                   try {
//                     // Ensure the camera is initialized
//                     await initializeControllerFuture;

//                     // Construye la ruta donde la imagen debe ser guardada usando
//                     // el paquete path.
//                     String path = join(
//                       //
//                       (await getTemporaryDirectory()).path,
//                       '${DateTime.now()}.png',
//                     );
//                     print(path);
//                     log('data: $path');

//                     // Attempt to take a picture and log where it's been saved
//                     // await controller.takePicture(path);
//                     // En este ejemplo, guarda la imagen en el directorio temporal. Encuentra
//                     // el directorio temporal usando el plugin `path_provider`.
//                     // Navigator.push(
//                     //   context,
//                     //   MaterialPageRoute(
//                     //     builder: (context) => DisplayPictureScreen(imagePath: path),
//                     //   ),
//                     // );
//                   } catch (e) {
//                     // Si se produce un error, regístralo en la consola.
//                     print('ee');
//                     print(e);
//                   }
//                 },
//               )
//             ],
//           );
//         } else {
//           // De lo contrario, muestra un indicador de carga
//           return Center(child: CircularProgressIndicator());
//         }
//       },
//     );

//     // return Container(
//     //   child:

//     //   Column(children: [
//     //     ClipRRect(
//     //       borderRadius: BorderRadius.circular(15.0),
//     //       child: Container(
//     //         width: MediaQuery.of(context).size.width * 0.6,
//     //         height: MediaQuery.of(context).size.height * 0.35,
//     //         child: CameraPreview(controller),
//     //       ),
//     //     ),

//     //     TextButton(
//     //       child: Icon(Icons.camera_alt),
//     //       // Agrega un callback onPressed
//     //       onPressed: () async {
//     //         print('jgjgjgjgjjgjgjgj');
//     //         // Toma la foto en un bloque de try / catch. Si algo sale mal,
//     //         // atrapa el error.
//     //         try {
//     //           // Ensure the camera is initialized
//     //           await _initializeControllerFuture;

//     //           // Construye la ruta donde la imagen debe ser guardada usando
//     //           // el paquete path.
//     //           String path = join(
//     //             //
//     //             (await getTemporaryDirectory()).path,
//     //             '${DateTime.now()}.png',
//     //           );
//     //           print(path);

//     //           // Attempt to take a picture and log where it's been saved
//     //           // await controller.takePicture(path);
//     //           // En este ejemplo, guarda la imagen en el directorio temporal. Encuentra
//     //           // el directorio temporal usando el plugin `path_provider`.
//     //           // Navigator.push(
//     //           //   context,
//     //           //   MaterialPageRoute(
//     //           //     builder: (context) => DisplayPictureScreen(imagePath: path),
//     //           //   ),
//     //           // );
//     //         } catch (e) {
//     //           // Si se produce un error, regístralo en la consola.
//     //           print(e);
//     //         }
//     //       },
//     //     )
//     //   ]),
//     // );
//     // return Container(
//     //   color: Colors.white,
//     //   child: Column(children: [
//     //     ClipRRect(
//     //       borderRadius: BorderRadius.circular(15.0),
//     //       child: Container(
//     //         width: MediaQuery.of(context).size.width * 0.6,
//     //         height: MediaQuery.of(context).size.height * 0.35,
//     //         child: CameraPreview(controller),
//     //       ),
//     //     ),

//     //     TextButton(
//     //       child: Icon(Icons.camera_alt),
//     //       // Agrega un callback onPressed
//     //       onPressed: () async {
//     //         print('jgjgjgjgjjgjgjgj');
//     //         // Toma la foto en un bloque de try / catch. Si algo sale mal,
//     //         // atrapa el error.
//     //         try {
//     //           // Ensure the camera is initialized
//     //           await _initializeControllerFuture;

//     //           // Construye la ruta donde la imagen debe ser guardada usando
//     //           // el paquete path.
//     //           String path = join(
//     //             //
//     //             (await getTemporaryDirectory()).path,
//     //             '${DateTime.now()}.png',
//     //           );
//     //           print(path);

//     //           // Attempt to take a picture and log where it's been saved
//     //           // await controller.takePicture(path);
//     //           // En este ejemplo, guarda la imagen en el directorio temporal. Encuentra
//     //           // el directorio temporal usando el plugin `path_provider`.
//     //           // Navigator.push(
//     //           //   context,
//     //           //   MaterialPageRoute(
//     //           //     builder: (context) => DisplayPictureScreen(imagePath: path),
//     //           //   ),
//     //           // );
//     //         } catch (e) {
//     //           // Si se produce un error, regístralo en la consola.
//     //           print(e);
//     //         }
//     //       },
//     //     )
//     //   ]),
//     // );
//     //  CameraPreview(controller)
//   }
// }
