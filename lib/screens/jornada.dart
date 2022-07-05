import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/screens.dart';
import 'package:flutter_application_2/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';

import '../blocs/blocs.dart';
import '../helpers/show_alert.dart';
import '../widgets/widgets.dart';

// Una pantalla que permite a los usuarios tomar una fotografía utilizando una cámara determinada.
class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({Key? key, required this.camera}) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late LocationBloc locationBloc;
  String sede = 'Central';

  @override
  void initState() {
    super.initState();
    // Para visualizar la salida actual de la cámara, es necesario
    // crear un CameraController.
    _controller = CameraController(
      // Obtén una cámara específica de la lista de cámaras disponibles
      widget.camera,
      // Define la resolución a utilizar
      ResolutionPreset.medium,
    );
    // A continuación, debes inicializar el controlador. Esto devuelve un Future!
    _initializeControllerFuture = _controller.initialize();

    locationBloc = BlocProvider.of<LocationBloc>(context);
    // locationBloc.getCurrentPosition();
    locationBloc.startFollowingUser();
  }

  @override
  void dispose() {
    locationBloc.stopFollowingUser();

    // Asegúrate de deshacerte del controlador cuando se deshaga del Widget.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double tam = MediaQuery.of(context).size.height * 0.17;
    double height = MediaQuery.of(context).size.height * 0.8;
    double width = MediaQuery.of(context).size.width * 0.9;
    double padding = MediaQuery.of(context).size.width * 0.1;
    final tamano = MediaQuery.of(context).size;
    final controlService = Provider.of<ControlService>(context);
    XFile? image; //for captured image

    return Scaffold(
      appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/logo.png',
                  fit: BoxFit.cover, alignment: Alignment.center),
            ),
            SizedBox(width: tam)
          ],
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () async {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => HomeScreen(),
                        transitionDuration: const Duration(milliseconds: 0)));
              }),
          backgroundColor: Colors.white,
          elevation: 1),
      // body: Targe(),
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          if (state.lastKnownLocation == null)
            return const Center(child: Text('Espere por favor...'));
          print(state.lastKnownLocation);

          return SingleChildScrollView(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: cardBordes(),
                    margin: EdgeInsets.only(top: 30),
                    height: height,
                    width: width,
                    child: Column(
                      children: [
                        const Text(
                          'Asistencia',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 30),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
                                child: FutureBuilder<void>(
                                  future: _initializeControllerFuture,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      // Si el Future está completo, muestra la vista previa
                                      return CameraPreview(_controller);
                                    } else {
                                      // De lo contrario, muestra un indicador de carga
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                  },
                                ),
                              ),
                              Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: IconButton(
                                      iconSize: 35,
                                      icon:
                                          const Icon(Icons.camera_alt_rounded),
                                      onPressed: () async {}))
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                          child: Column(
                            children: [
                              Container(
                                child: BlocBuilder<GpsBloc, GpsState>(
                                    builder: (context, state) {
                                  print('state: ${state}');
                                  return state.isAllGranted
                                      ? Activo()
                                      : AlertMap();
                                }),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: DropdownButtonFormField<String>(
                              value: 'central',
                              items: const [
                                DropdownMenuItem(
                                    value: 'central',
                                    child: Text('Sede Central')),
                                DropdownMenuItem(
                                    value: 'sur', child: Text('Sede Sur')),
                                DropdownMenuItem(
                                    value: 'norte', child: Text('Sede Norte')),
                                DropdownMenuItem(
                                    value: 'cerete',
                                    child: Text('Sede Cerete')),
                              ],
                              onChanged: (value) {
                                print(value);
                                this.sede = value!;
                              }),
                        ),
                        // MyStatefulWidget(),
                        SizedBox(height: 5),

                        ElevatedButton.icon(
                          onPressed: () async {
                            try {
                              await _initializeControllerFuture;
                              //   try {
                              //   if (controller != null) {
                              //     //check if contrller is not null
                              //     if (controller!.value.isInitialized) {
                              //       //check if controller is initialized
                              //       image = await controller!.takePicture();
                              //       log('${image?.path}'); //capture image
                              //       setState(() {
                              //         //update UI
                              //       });
                              //     }
                              //   }
                              // } catch (e) {
                              //   print(e); //show error
                              // }
                              // String? path = image?.path;

                              // print('entro');
                              // log('---->');
                              // log('--->$path ---------------------');

                              // image = await _controller.takePicture();

                              // final location = state.lastKnownLocation!;
                              // final lat = location.latitude;
                              // final lon = location.longitude;
                              // final controlnOk =
                              //     await controlService.asistencia(path);

                              // if (controlnOk) {
                              //   // TODO: Conectar a nuestro socket server
                              //   Navigator.pushReplacementNamed(
                              //       context, 'check');
                              // } else {
                              //   // Mostara alerta
                              //   return mostrarAlerta(
                              //       context,
                              //       'Datos incorrectos',
                              //       'Por favor verifique los datos');
                              // }
                            } catch (e) {
                              print(e);
                            }
                          },
                          icon: const Icon(
                            Icons.check_sharp,
                            size: 35.0,
                          ),
                          label: const Text(
                            'Aceptar',
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),

      //  Padding(
      //   padding: const EdgeInsets.all(20),
      //   child: Container(
      //     decoration: cardBordes(),
      //     margin: EdgeInsets.only(top: 30),
      //     height: height,
      //     width: width,
      //     child: Column(
      //       children: [
      //         const Text(
      //           'Asistencia',
      //           style: TextStyle(
      //               color: Colors.black,
      //               fontSize: 30,
      //               fontWeight: FontWeight.bold),
      //         ),
      //         SizedBox(height: 30),
      //         ClipRRect(
      //           borderRadius: BorderRadius.circular(15.0),
      //           child: Stack(
      //             children: [
      //               Container(
      //                 width: MediaQuery.of(context).size.width * 0.6,
      //                 height: MediaQuery.of(context).size.height * 0.35,
      //                 child: FutureBuilder<void>(
      //                   future: _initializeControllerFuture,
      //                   builder: (context, snapshot) {
      //                     if (snapshot.connectionState ==
      //                         ConnectionState.done) {
      //                       // Si el Future está completo, muestra la vista previa
      //                       return CameraPreview(_controller);
      //                     } else {
      //                       // De lo contrario, muestra un indicador de carga
      //                       return Center(child: CircularProgressIndicator());
      //                     }
      //                   },
      //                 ),
      //               ),
      //               Positioned(
      //                   right: 0,
      //                   bottom: 0,
      //                   child: IconButton(
      //                       iconSize: 35,
      //                       icon: const Icon(Icons.camera_alt_rounded),
      //                       onPressed: () async {}))
      //             ],
      //           ),
      //         ),
      //         SizedBox(height: 30),
      //         Padding(
      //           padding:
      //               const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      //           child: Column(
      //             children: [
      //               Container(
      //                 child: BlocBuilder<GpsBloc, GpsState>(
      //                     builder: (context, state) {
      //                   print('state: ${state}');
      //                   return state.isAllGranted ? Activo() : AlertMap();
      //                 }),
      //               ),
      //             ],
      //           ),
      //         ),
      //         SizedBox(height: 5),
      //         ElevatedButton.icon(
      //           onPressed: () async {
      //             try {
      //               await _initializeControllerFuture;
      //               String path = join(
      //                 (await getTemporaryDirectory()).path,
      //                 '${DateTime.now()}.png',
      //               );
      //               print('entro');
      //               print(path);
      //             } catch (e) {
      //               print(e);
      //             }
      //           },
      //           icon: const Icon(
      //             Icons.check_sharp,
      //             size: 35.0,
      //           ),
      //           label: const Text(
      //             'Aceptar',
      //             style: TextStyle(fontSize: 20),
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  BoxDecoration cardBordes() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 3), blurRadius: 10)
          ]);
}

// Un Widget que muestra la imagen tomada por el usuario
// class DisplayPictureScreen extends StatelessWidget {
//   final String imagePath;

//   const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Display the Picture')),
//       // La imagen se almacena como un archivo en el dispositivo. Usa el
//       // constructor `Image.file` con la ruta dada para mostrar la imagen
//       body: Image.file(File(imagePath)),
//     );
//   }
// }

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String dropdownValue = 'Central';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? newValue) {
          log('------>${newValue}');
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: <String>['Central', 'Sur', 'Cerete', 'Norte']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
