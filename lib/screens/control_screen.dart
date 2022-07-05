import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
// import 'package:gobernacion/data/encryption.dart';
// import 'package:gobernacion/models/models.dart';
// import 'package:gobernacion/provider/provider.dart';
// import 'package:gobernacion/services/services.dart';
// import 'package:gobernacion/ui/screen/screen.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_application_2/data/encryption.dart';
import 'package:flutter_application_2/models/models.dart';
import 'package:flutter_application_2/screens/screens.dart';
import 'package:flutter_application_2/services/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/provider.dart';
import '../widgets/widgets.dart';

class ControlScreen extends StatelessWidget {
  const ControlScreen({Key? key}) : super(key: key);

  void displayDialono(BuildContext context) {
    final carnetservice = Provider.of<CarnetService>(context, listen: false);
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
              elevation: 5,
              title: Text('Usuario no encontrado',
                  style: TextStyle(color: Colors.blue)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(10)),
              content:
                  Column(mainAxisSize: MainAxisSize.min, children: const []),
              actions: [
                Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.orange.shade500),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Aceptar')),
                )
              ]);
        });
  }

  void displayDialog(BuildContext context, Usuario model) {
    final carnetservice = Provider.of<CarnetService>(context, listen: false);
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
              actionsPadding: EdgeInsets.zero,
              contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              elevation: 5,
              content: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: CardWidget(dato: model)),
              actions: [
                Row(
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
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                        onPressed: () async {
                          Usuario dato1 = Usuario();
                          print('loadCartUser');
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          String? kitJson = prefs.getString("content");
                          final String? userStr = prefs.getString('content');
                          print('--------------------------');
                          print('--------------------------');

                          if (userStr != null) {
                            print('entro');
                            Map<String, dynamic> userMap = jsonDecode(userStr);
                            dato1 = Usuario.fromJson(userMap);
                          }
                          DateTime now = new DateTime.now();
                          Control con = Control(
                            documentoAdmin: dato1.documento,
                            nombreAdmin: dato1.nombre1,
                            apellidoAdmin: dato1.apellido1,
                            documentoUser: model.documento,
                            nombreUser: model.nombre1,
                            apellidoUser: model.apellido1,
                            cargoUser: model.cargo,
                            dependenciaUser: model.dependencia,
                            hora: "${now}",
                          );
                          //  await carnetservice.loadControlAdmin(con);
                          print('jfjfjfjfjjfjfjfjrururururururur');
                          Navigator.pop(context);
                        },
                        label: const Text('Aceptar ',
                            style: TextStyle(fontSize: 15))),
                  ],
                )
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    final EncryptionService encryptionService = new EncryptionService();
    //  final CheckInternetConnection conexion = new CheckInternetConnection();
    //  final con = conexion.internetStatus();

    final loginForm = InputsDocumentForms();
    // final loginForm = Provider.of<InputsDocumentForms>(context);
    final carnetservice = Provider.of<CarnetService>(context);
    // final authService = Provider.of<AuthService>(context, listen: false);

    // final carnetservice = CarnetService();
    final authService = AuthService();
    final prefe = UserPrefe();

    final double tam = MediaQuery.of(context).size.height * 0.17;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        key: _scaffoldKey,
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
                icon: const Icon(Icons.close, color: Colors.black),
                onPressed: () async {
                  await prefe.logout();
                  //  Navigator.pushReplacementNamed(context, 'login');
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, __, ___) => LoginPage(),
                          transitionDuration: const Duration(seconds: 0)));
                }),
            backgroundColor: Colors.white,
            elevation: 1),

        // body: Padding(
        //   padding:
        //       const EdgeInsets.only(top: 60, right: 40, left: 40, bottom: 40),
        //   child: Container(
        //       padding: const EdgeInsets.symmetric(horizontal: 20),
        //       width: double.infinity,
        //       height: 250,
        //       decoration: _buildBoxDecoration(),
        //       child: Column(
        //         children: [
        //           Form(
        //               key: loginForm.formKey1,
        //               autovalidateMode: AutovalidateMode.onUserInteraction,
        //               child: Column(children: [
        //                 const SizedBox(height: 30),
        //                 TextFormField(
        //                   autofocus: true,
        //                   keyboardType: TextInputType.number,
        //                   decoration: InputDecorations.authInputDecoration(
        //                       hinText: '12134',
        //                       labelText: 'Numero de identificacion'),
        //                   onChanged: (value) => loginForm.documento = value,
        //                 ),
        //                 const SizedBox(height: 30),
        //               ])),
        //           Padding(
        //             padding: const EdgeInsets.symmetric(vertical: 20),
        //             child: Center(
        //               child: ElevatedButton.icon(
        //                   icon: const Icon(Icons.search),
        //                   style: ElevatedButton.styleFrom(
        //                       shape: const StadiumBorder(),
        //                       primary: Colors.orange),
        //                   onPressed: loginForm.isLoading
        //                       ? null
        //                       : () async {
        //                           // FocusScope.of(context).unfocus();
        //                           print('entryyyyyyyyo');
        //                           // final authService = Provider.of<AuthService>(
        //                           //     context,
        //                           //     listen: false);
        //                           final authService = AuthService();

        //                           if (!loginForm.isValidForm()) return;

        //                           print('paso por aaqui ');
        //                           loginForm.isLoading = true;
        //                           //Validar si el login es correc
        //                           Usuario scans = await carnetservice
        //                               .loadCarstAdmin(loginForm.documento);
        //                           if (scans.cargo == null) {
        //                             loginForm.isLoading = false;
        //                             displayDialono(context);
        //                           } else {
        //                             loginForm.isLoading = false;
        //                             // displayDialog(context,scans);
        //                             log('--->$scans');
        //                             Navigator.pushReplacement(
        //                                 context,
        //                                 PageRouteBuilder(
        //                                     pageBuilder: (_, __, ___) =>
        //                                         AccesoScreen(user: scans),
        //                                     transitionDuration:
        //                                         const Duration(seconds: 0)));
        //                             //Navigator.of(context).pushReplacementNamed('home');

        //                             // Navigator.pushNamed(context, 'acceso');
        //                             // Navigator.pushReplacementNamed(context, 'home');
        //                           }
        //                         },
        //                   label: const Text('Consultar ',
        //                       style: TextStyle(fontSize: 20))),
        //             ),
        //           ),
        //         ],
        //       )),
        // ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 60, right: 40, left: 40, bottom: 40),
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              height: 250,
              decoration: _buildBoxDecoration(),
              child: Column(
                children: [
                  Form(
                      key: loginForm.formKey1,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(children: [
                        const SizedBox(height: 30),
                        TextFormField(
                          autofocus: true,
                          keyboardType: TextInputType.number,
                          decoration: InputDecorations.authInputDecoration(
                              hinText: '12134',
                              labelText: 'Numero de identificacion'),
                          onChanged: (value) => loginForm.documento = value,
                        ),
                        const SizedBox(height: 30),
                      ])),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: ElevatedButton.icon(
                          icon: const Icon(Icons.search),
                          style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              primary: Colors.orange),
                          onPressed: loginForm.isLoading
                              ? null
                              : () async {
                                  FocusScope.of(context).unfocus();
                                  print('entryyyyyyyyo');
                                  // final authService= Provider.of<AuthService>(context, listen:false);
                                  if (!loginForm.isValidForm()) return;

                                  print('paso por aaqui ');
                                  loginForm.isLoading = true;
                                  //Validar si el login es correc
                                  final Usuario scans = await carnetservice
                                      .loadCarstAdmin(loginForm.documento);
                                  //               if(scans.documento==null){
                                  //                 loginForm.isLoading= false;
                                  //                   displayDialono(context);
                                  //                   }else{
                                  //                   loginForm.isLoading= false;
                                  //                   // displayDialog(context,scans);
                                  //                       Navigator.pushReplacement(context, PageRouteBuilder(
                                  //                 pageBuilder: ( _ , __ , ___) => const AccesoScreen(),
                                  //                 transitionDuration: const Duration( seconds: 0)
                                  //               ));
                                  // //Navigator.of(context).pushReplacementNamed('home');

                                  //     // Navigator.pushNamed(context, 'acceso');
                                  //     // Navigator.pushReplacementNamed(context, 'home');
                                  //     }
                                },
                          label: const Text('Consultar ',
                              style: TextStyle(fontSize: 20))),
                    ),
                  ),
                ],
              )),
        ),

        // drawer: DrawerWidget(),

        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.qr_code_2_outlined),
          onPressed: () async {
            String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                '#3D8BEF', 'Cancelar', false, ScanMode.QR);
            try {
              if (barcodeScanRes == '-1') {
                //no hace nada y sale
              } else {
                //En caso tal que la respuesta sea nula
                if (await encryptionService.descrypData(barcodeScanRes) ==
                    null) {
                  NotificationsService.showSnackbar(
                      'Codigo QR Invalido encryption');
                } else {
                  Usuario scans = await carnetservice.loadCarstAdmin(
                      await encryptionService.descrypData(barcodeScanRes));
                  if (scans.documento == null) {
                    displayDialono(context);
                  } else {
                    Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (_, __, ___) =>
                                AccesoScreen(user: scans),
                            transitionDuration: const Duration(seconds: 0)));
                  }
                }
              }
            } catch (e) {
              print(e);
              NotificationsService.showSnackbar('$e');
            }
          },
        ));
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.009),
                offset: const Offset(0, 5),
                blurRadius: 5)
          ]);
}

class _Foto extends StatelessWidget {
  const _Foto({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final tamano = MediaQuery.of(context).size;
    String url =
        'https://thumbs.dreamstime.com/z/retrato-de-hombre-mirando-la-c%C3%A1mara-sobre-el-fondo-blanco-158750254.jpg';
    final url1 = null;
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Center(
        child: Container(
            height: tamano.height * 0.2,
            width: tamano.width * 0.5,
            child: url == null
                ? Image(
                    image: const AssetImage('assets/persona.jpeg'),
                    fit: BoxFit.cover)
                : FadeInImage(
                    placeholder: const AssetImage('assets/loading.gif'),
                    image: NetworkImage(url),
                    fit: BoxFit.cover)),
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  const _ProductForm({
    Key? key,
  }) : super(key: key);

  void displayDialog(BuildContext context, int documento) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
              elevation: 5,
              title: Text('${documento}', style: TextStyle(color: Colors.blue)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(10)),
              content: Column(mainAxisSize: MainAxisSize.min, children: const [
                Text(
                    'Qui aute reprehenderit dolor ipsum occaecat reprehenderit. Ullamco ex ad dolore voluptate occaecat non ea laborum et Lorem eiusmod eu magna aliquip. Enim minim et laborum nostrud consequat velit est cupidatat tempor. Ad exercitation incididunt laboris magna consectetur adipisicing voluptate eu consequat velit ad. Minim esse et culpa aute amet ullamco.')
              ]),
              actions: [
                Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.orange.shade500),
                      onPressed: () {
                        // widget.check!.terms = true;
                        Navigator.pop(context);
                      },
                      child: const Text('Aceptar')),
                )
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, right: 20, left: 40, bottom: 40),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: 250,
          decoration: _buildBoxDecoration(),
          child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(children: [
                const SizedBox(height: 30),
                TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecorations.authInputDecoration(
                      hinText: '12134', labelText: 'Numero de identificacion'),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.orange.shade500),
                      onPressed: () {
                        print('entros');
                        int documentId = 111;
                        displayDialog(context, documentId);
                        Navigator.pop(context);
                        print('paso');
                      },
                      child: const Text('Consultar',
                          style: TextStyle(fontSize: 20))),
                ),
              ]))),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.009),
                offset: const Offset(0, 5),
                blurRadius: 5)
          ]);
}
