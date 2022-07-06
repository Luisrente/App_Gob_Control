import 'dart:developer';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/dd/login_form_provider.dart';
import 'package:flutter_application_2/helpers/show_alert.dart';
import 'package:flutter_application_2/screens/screens.dart';
import 'package:flutter_application_2/services/services.dart';
import 'package:flutter_application_2/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../blocs/blocs.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CameraDescription>? cameras; //list out the camera available
  CameraController? controller; //controller for camera
  XFile? image; //for captured image
  late LocationBloc locationBloc;

  @override
  void initState() {
    loadCamera();
    super.initState();

    locationBloc = BlocProvider.of<LocationBloc>(context);
    // locationBloc.getCurrentPosition();
    locationBloc.startFollowingUser();
  }

  loadCamera() async {
    cameras = await availableCameras();
    if (cameras != null) {
      int cam = 1;
      if (cameras![1] == null) {
        cam = 0;
      }
      controller = CameraController(cameras![cam], ResolutionPreset.max);
      //cameras[0] = first camera, change to 1 to another camera
      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    } else {
      print("NO any camera found");
    }
  }

  @override
  void dispose() {
    locationBloc.stopFollowingUser();

    // Asegúrate de deshacerte del controlador cuando se deshaga del Widget.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controlService = Provider.of<ControlService>(context);
    final double tam = MediaQuery.of(context).size.height * 0.17;
    double height = MediaQuery.of(context).size.height * 0.8;
    double width = MediaQuery.of(context).size.width * 0.9;
    final loginForm = Provider.of<LoginFormProvider>(context);

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
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  height:
                                      MediaQuery.of(context).size.height * 0.35,
                                  child: controller == null
                                      ? Center(child: Text("Loading Camera..."))
                                      : !controller!.value.isInitialized
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : CameraPreview(controller!)),
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
                        MyStatefulWidget(),
                        Form(
                          key: loginForm.formKey,
                          child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              disabledColor: Colors.grey,
                              elevation: 0,
                              color: Color.fromARGB(255, 2, 116, 208),
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 70, vertical: 15),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text(
                                      loginForm.isLoading
                                          ? 'Espere...'
                                          : 'Ingresar',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  )),
                              onPressed: loginForm.isLoading
                                  ? null
                                  : () async {
                                      FocusScope.of(context).unfocus();

                                      final authService =
                                          Provider.of<AuthService>(context,
                                              listen: false);

                                      loginForm.isLoading = true;
                                      try {
                                        final location =
                                            state.lastKnownLocation!;
                                        final longitud = location.longitude;
                                        final latitud = location.longitude;
                                        if (controller != null) {
                                          //check if contrller is not null
                                          if (controller!.value.isInitialized) {
                                            //check if controller is initialized
                                            image =
                                                await controller!.takePicture();
                                            String? path = image?.path;
                                            String sede = loginForm.isList;

                                            log('.llll-----Zdddddd--->$sede');
                                            try {
                                              final controlnOk =
                                                  await controlService
                                                      .asistencia(longitud,
                                                          latitud, path, sede);
                                              if (controlnOk) {
                                                // TODO: Conectar a nuestro socket server
                                                // Navigator.pushReplacementNamed(
                                                //     context, 'check');
                                                loginForm.isLoading = false;

                                                Navigator.pushReplacement(
                                                    context,
                                                    PageRouteBuilder(
                                                        pageBuilder: (_, __,
                                                                ___) =>
                                                            const HomeScreen(),
                                                        transitionDuration:
                                                            const Duration(
                                                                milliseconds:
                                                                    0)));
                                              } else {
                                                loginForm.isLoading = false;
                                                // Mostara alerta
                                                return mostrarAlerta(
                                                    context,
                                                    'Datos incorrectos',
                                                    'Por favor verifique los datos');
                                              }
                                            } catch (e) {
                                              loginForm.isLoading = false;
                                              print(e);
                                            }
                                            //capture image
                                            setState(() {
                                              //update UI
                                            });
                                          }
                                        }
                                      } catch (e) {
                                        print(e);
                                      }
                                    }),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),

      //   Container(
      //       child: Column(children: [
      //     Container(
      //         height: 300,
      //         width: 400,
      //         child: controller == null
      //             ? Center(child: Text("Loading Camera..."))
      //             : !controller!.value.isInitialized
      //                 ? Center(
      //                     child: CircularProgressIndicator(),
      //                   )
      //                 : CameraPreview(controller!)),
      //     ElevatedButton.icon(
      //       //image capture button
      //       onPressed: () async {
      //         try {
      //           if (controller != null) {
      //             //check if contrller is not null
      //             if (controller!.value.isInitialized) {
      //               //check if controller is initialized
      //               image = await controller!.takePicture();
      //               String? path = image?.path;

      //               try {
      //                 final controlnOk = await controlService.asistencia(path);

      //                 if (controlnOk) {
      //                   // TODO: Conectar a nuestro socket server
      //                   Navigator.pushReplacementNamed(context, 'check');
      //                 } else {
      //                   // Mostara alerta
      //                   return mostrarAlerta(context, 'Datos incorrectos',
      //                       'Por favor verifique los datos');
      //                 }
      //               } catch (e) {
      //                 print(e);
      //               }
      //               //capture image
      //               setState(() {
      //                 //update UI
      //               });
      //             }
      //           }
      //         } catch (e) {
      //           print(e); //show error
      //         }
      //       },
      //       icon: Icon(Icons.camera),
      //       label: Text("Capture"),
      //     ),
      //     Container(
      //       //show captured image
      //       padding: EdgeInsets.all(30),
      //       child: image == null
      //           ? Text("No image captured")
      //           : Image.file(
      //               File(image!.path),
      //               height: 300,
      //             ),
      //       //display captured image
      //     )
      //   ])),
      // );
    );
  }
}

BoxDecoration cardBordes() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 10)
        ]);

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    final sedeService = Provider.of<SedeService>(context);
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<String>>(
            future: sedeService.listsede(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                late List<String> nombre;
                nombre = snapshot.data!;
                String dropdownValue = nombre[0];
                return Container(
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.blue, fontSize: 25),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      log('------>${newValue}');
                      loginForm.isList = newValue!;
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: nombre
                        // items: <String>['Central', 'Sur', 'Cerete', 'Norte']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.black12),
                );
              }
            }));
  }
}
