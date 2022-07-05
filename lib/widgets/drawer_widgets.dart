import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/user.dart';
import 'package:flutter_application_2/screens/screenCamara.dart';
import 'package:flutter_application_2/screens/screens.dart';
import 'package:flutter_application_2/services/services.dart';
import 'package:flutter_application_2/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

// import '../../models/models.dart';
// import '../../services/services.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  void displayDialog(BuildContext context, String model) {
    final carnetservice = Provider.of<CarnetService>(context, listen: false);
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
              elevation: 5,
              title: const Center(
                child: Text('Verificar', style: TextStyle(color: Colors.black)),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(10)),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ProductImage(url: model),
                )
              ]),
              actions: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                          icon: const Icon(Icons.close),
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          onPressed: () {
                            // widget.check!.terms = true;
                            Navigator.pop(context);
                          },
                          label: const Text('Cancelar',
                              style: TextStyle(fontSize: 15))),
                      SizedBox(width: 10),
                      ElevatedButton.icon(
                          icon: const Icon(Icons.check),
                          style:
                              ElevatedButton.styleFrom(primary: Colors.green),
                          onPressed: () {
                            // widget.check!.terms = true;
                            if ((carnetservice.uploadImage(model)) == null) {
                              // NotificationsService.showSnackbar('No se guardo');
                            }
                            print('entro aqui');
                            Navigator.pop(context);
                          },
                          label: const Text('Aceptar ',
                              style: TextStyle(fontSize: 15))),
                    ],
                  ),
                )
              ]);
        });
  }

  Usuario dato1 = Usuario();
  Usuario dato = Usuario();

  @override
  void initState() {
    super.initState();
    datos();
    log('${datos()}');
  }

  Future<Usuario> datos() async {
    // Future<Usuario> datos() async {
    final prefe = UserPrefe();
    dato1 = await prefe.getUserInfo();
    return dato1;

    log('----->${dato1.apellido1}');
  }

  @override
  void dispose() {
    // Asegúrate de deshacerte del controlador cuando se deshaga del Widget.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final prefe = Provider.of<UserPrefe>(context, listen: false);
    final prefe = UserPrefe();
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.

      child: FutureBuilder<Usuario>(
          future: datos(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: ListView(
                  // Important: Remove any padding from the ListView.
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(dato: snapshot.data!),
                    DrawerNavigationItem(
                      iconData: Icons.device_hub_rounded,
                      title: 'Control Asistencia',
                      selected: false,
                      onTap: () async {
                        // Usuario dato = await prefe.getUserInfo();

                        if (dato1.dependencia == 'Visitante') {
                          print('${dato1.dependencia}');
                        } else {
                          Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => LoadingScreen(),
                                  // pageBuilder: (_, __, ___) => LoadingScreen(),
                                  transitionDuration:
                                      const Duration(seconds: 0)));
                        }

                        // Navigator.pushReplacement(
                        //     context,
                        //     PageRouteBuilder(
                        //         pageBuilder: (_, __, ___) => LoadingScreen(),
                        //         // pageBuilder: (_, __, ___) => LoadingScreen(),
                        //         transitionDuration:
                        //             const Duration(seconds: 0)));
                      },
                    ),
                    DrawerNavigationItem(
                      iconData: Icons.list_alt,
                      title: "Registro Asistencia",
                      selected: false,
                      onTap: () {
                        if (dato1.dependencia == 'Visitante') {
                          print('${dato1.dependencia}');
                        } else {
                          Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                  pageBuilder: (_, __, ___) =>
                                      ListAssitScreen(),
                                  // pageBuilder: (_, __, ___) => LoadingScreen(),
                                  transitionDuration:
                                      const Duration(seconds: 0)));
                        }
                      },
                    ),
                    DrawerNavigationItem(
                      iconData: Icons.access_time,
                      title: "Sedes",
                      selected: false,
                      onTap: () {
                        if (dato1.dependencia == 'Visitante') {
                          print('${dato1.dependencia}');
                        } else {
                          Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                  pageBuilder: (_, __, ___) =>
                                      ListAssitScreen(),
                                  // pageBuilder: (_, __, ___) => LoadingScreen(),
                                  transitionDuration:
                                      const Duration(seconds: 0)));
                        }
                        // Navigator.pushReplacement(
                        //     context,
                        //     PageRouteBuilder(
                        //         pageBuilder: (_, __, ___) => ListAssitScreen(),
                        //         transitionDuration:
                        //             const Duration(seconds: 0)));
                      },
                    ),
                    DrawerNavigationItem(
                        iconData: Icons.close,
                        title: "Salir ",
                        selected: false,
                        onTap: () async {
                          await prefe.logout();
                          //  Navigator.pushReplacementNamed(context, 'login');
                          Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => LoginPage(),
                                  transitionDuration:
                                      const Duration(seconds: 0)));
                        }),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(color: Colors.black12),
              );
            }
          }),

      // child: Container(
      //   child: ListView(
      //     // Important: Remove any padding from the ListView.
      //     padding: EdgeInsets.zero,
      //     children: [
      //       DrawerHeader(dato: datos()),
      //       DrawerNavigationItem(
      //         iconData: Icons.device_hub_rounded,
      //         title: '${dato1.apellido1}',
      //         selected: false,
      //         onTap: () async {
      //           // Usuario dato = await prefe.getUserInfo();

      //           if (dato1.dependencia == 'Visitante') {}

      //           Navigator.pushReplacement(
      //               context,
      //               PageRouteBuilder(
      //                   pageBuilder: (_, __, ___) => LoadingScreen(),
      //                   // pageBuilder: (_, __, ___) => LoadingScreen(),
      //                   transitionDuration: const Duration(seconds: 0)));
      //         },
      //       ),
      //       DrawerNavigationItem(
      //         iconData: Icons.list_alt,
      //         title: "Registro Asistencia",
      //         selected: false,
      //         onTap: () {
      //           Navigator.pushReplacement(
      //               context,
      //               PageRouteBuilder(
      //                   pageBuilder: (_, __, ___) => ListAssitScreen(),
      //                   transitionDuration: const Duration(seconds: 0)));
      //         },
      //       ),
      //       DrawerNavigationItem(
      //           iconData: Icons.close,
      //           title: "Salir ",
      //           selected: false,
      //           onTap: () async {
      //             await prefe.logout();
      //             //  Navigator.pushReplacementNamed(context, 'login');
      //             Navigator.pushReplacement(
      //                 context,
      //                 PageRouteBuilder(
      //                     pageBuilder: (_, __, ___) => LoginPage(),
      //                     transitionDuration: const Duration(seconds: 0)));
      //           }),
      //     ],
      //   ),
      // ),
    );
  }
}

class DrawerNavigationItem extends StatelessWidget {
  final IconData iconData;
  final String title;
  final bool selected;
  final Function() onTap;
  const DrawerNavigationItem({
    Key? key,
    required this.iconData,
    required this.title,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      leading: Icon(iconData),
      onTap: onTap,
      title: Text(title),
      selectedTileColor: Colors.blueAccent.shade100,
      selected: selected,
      selectedColor: Colors.black87,
    );
  }
}

class DrawerHeader extends StatelessWidget {
  final Usuario dato;
  const DrawerHeader({
    Key? key,
    required this.dato,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[700],
      width: double.infinity,
      height: 220,
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 30),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/persona.jpeg'),
              ),
            ),
            // child: Container
            // (child: ProductImage()),
          ),
          Text(
            '${dato.nombre1} ${dato.apellido1}',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            ' ${dato.correo}',
            style: TextStyle(
              color: Colors.grey[200],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
