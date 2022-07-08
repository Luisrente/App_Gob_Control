import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/dd/login_form_provider.dart';
import 'package:flutter_application_2/provider/provider.dart';
import 'package:flutter_application_2/screens/screens.dart';
import 'package:flutter_application_2/services/services.dart';
import 'package:flutter_application_2/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:photo_gallery/photo_gallery.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({Key? key}) : super(key: key);

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double tam = MediaQuery.of(context).size.height * 0.17;
    final carnetservice = Provider.of<CarnetService>(context);
    double padding = MediaQuery.of(context).size.width * 0.07;
    double height = MediaQuery.of(context).size.height * 0.60;
    final tamano = MediaQuery.of(context).size;
    final loginForm = Provider.of<LoginFormProvider>(context);
    // String photo = '';
    return Scaffold(
      appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: SizedBox(
                height: kToolbarHeight - 15,
                child: Image.asset('assets/logo.png'),
              ),
            ),
          ),
          toolbarHeight: kToolbarHeight,
          backgroundColor: Colors.white,
          elevation: 1),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding, vertical: 30),
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Stack(
                        children: [
                          Container(
                            height: tamano.height * 0.33,
                            width: tamano.width * 0.47,
                            child: getImage(carnetservice.selectedProduct.img),
                          ),
                          Positioned(
                              right: 0,
                              bottom: 0,
                              child: IconButton(
                                  iconSize: 35,
                                  icon: const Icon(Icons.camera_alt_rounded),
                                  onPressed: () async {
                                    final picker = new ImagePicker();
                                    final XFile? image = await picker.pickImage(
                                        source: ImageSource.gallery);
                                    final s = image?.path;
                                    if (s == null) {
                                      loginForm.isLoadingPhoto = true;
                                    } else {
                                      // photo = s;
                                      carnetservice.selectedProduct.img = s;
                                      loginForm.isLoadingPhoto = false;
                                    }
                                  })),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
            MaterialButton(
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
                        loginForm.isLoadingPhoto ? 'Espere...' : 'Ingresar',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    )),
                onPressed: loginForm.isLoadingPhoto
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();
                        String? photo = carnetservice.selectedProduct.img;

                        log('----ffff----->${photo}');
                        try {
                          final t = await carnetservice.uploadImage(photo);
                          log('----rrrkkrkrkrkrkkrkrkrk----->${t}');

                          if (t == false) {
                          } else {
                            Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                    pageBuilder: (_, __, ___) =>
                                        const HomeScreen(),
                                    transitionDuration:
                                        const Duration(milliseconds: 0)));
                          }

                          log('---->$t');
                        } catch (e) {
                          log('---->$e');
                        }

                        // final authService =
                        //     Provider.of<AuthService>(
                        //         context,
                        //         listen: false);
                        // loginForm.isLoading = true;
                        // try {
                        //   final location =
                        //       state.lastKnownLocation!;
                        //   final longitud =
                        //       location.longitude;
                        //   final latitud = location.latitude;
                        //   if (controller != null) {
                        //     //check if contrller is not null
                        //     if (controller!
                        //         .value.isInitialized) {
                        //       //check if controller is initialized
                        //       image = await controller!
                        //           .takePicture();
                        //       String? path = image?.path;
                        //       String sede =
                        //           loginForm.isList;
                        //       log('.llll-----Zdddddd--->$sede');
                        //       try {
                        //         final controlnOk =
                        //             await controlService
                        //                 .asistencia(
                        //                     longitud,
                        //                     latitud,
                        //                     path,
                        //                     sede);
                        //         if (controlnOk) {
                        //           // TODO: Conectar a nuestro socket server
                        //           // Navigator.pushReplacementNamed(
                        //           //     context, 'check');
                        //           loginForm.isLoading =
                        //               false;
                        //           Navigator.pushReplacement(
                        //               context,
                        //               PageRouteBuilder(
                        //                   pageBuilder: (_,
                        //                           __,
                        //                           ___) =>
                        //                       const HomeScreen(),
                        //                   transitionDuration:
                        //                       const Duration(
                        //                           milliseconds:
                        //                               0)));
                        //         } else {
                        //           loginForm.isLoading =
                        //               false;
                        //           // Mostara alerta
                        //           return mostrarAlerta(
                        //               context,
                        //               'Datos incorrectos',
                        //               'Por favor verifique los datos');
                        //         }
                        //       } catch (e) {
                        //         loginForm.isLoading = false;
                        //         print(e);
                        //       }
                        //       //capture image
                        //       setState(() {
                        //         //update UI
                        //       });
                        //     }
                        //   }
                        // } catch (e) {
                        //   print(e);
                        // }
                      }),
            TextButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const HomeScreen(),
                          transitionDuration: const Duration(milliseconds: 0)));
                },
                icon: Icon(
                  Icons.flaky,
                  color: Colors.black12,
                ),
                label: Text('Omitir', style: TextStyle(color: Colors.black38)))
          ],
        ),
      ),
    );
  }

  BoxDecoration cardBordes() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 3), blurRadius: 10)
          ]);

  Widget getImage(picture) {
    // return const Image(
    //     image: AssetImage('assets/persona.jpeg'), fit: BoxFit.cover);

    // if (picture == null) {
    //   return const Image(
    //       image: AssetImage('assets/persona.jpeg'), fit: BoxFit.cover);
    // } else {
    //   return Image.file(File(picture), fit: BoxFit.cover);
    // }

    try {
      if (picture == null) {
        return const Image(
            image: AssetImage('assets/persona.jpeg'), fit: BoxFit.cover);
      } else {
        return Image.file(File(picture), fit: BoxFit.cover);
      }
    } catch (e) {
      return const Image(
          image: AssetImage('assets/persona.jpeg'), fit: BoxFit.cover);
    }

    // if (picture.startsWith('http')) {
    //   try {
    //     return FadeInImage(
    //       image: NetworkImage(''),
    //       placeholder: const AssetImage('assets/loading.gif'),
    //       fit: BoxFit.cover,
    //     );

    //     // return CachedNetworkImage(
    //     //     // placeholder: CircularProgressIndicator(),
    //     //     imageUrl: this.url!,
    //     //     fit: BoxFit.cover);
    //   } catch (e) {
    //     return const Image(
    //         image: AssetImage('assets/persona.jpeg'), fit: BoxFit.cover);
    //   }
    // }
    // return Image.file(File(picture), fit: BoxFit.cover);

    // return const Image(
    //     image: AssetImage('assets/persona.jpeg'), fit: BoxFit.cover);
  }
}
