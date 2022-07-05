import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/screens.dart';
import 'package:flutter_application_2/services/services.dart';
import 'package:flutter_application_2/widgets/widgets.dart';
// import 'package:gobernacion/services/services.dart';
// import 'package:gobernacion/ui/screen/screen.dart';
// import 'package:gobernacion/ui/widgets/widgets.dart';
// import 'package:gob_cordoba/models/control.dart';
// import 'package:gob_cordoba/models/user.dart';
// import 'package:gob_cordoba/services/carnet_services.dart';
// import 'package:gob_cordoba/ui/screen/control_screen.dart';
// import 'package:gob_cordoba/ui/widgets/cart_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/models.dart';

class AccesoScreen extends StatelessWidget {
  final Usuario user;
  const AccesoScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final carnetservice = CarnetService();
    // final carnetservice = Provider.of<CarnetService>(context, listen: false);
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [CardWidget(dato: user), AccesoWidget(carnetservice: user)],
        ),
      ),
    ));
  }
}

class AccesoWidget extends StatelessWidget {
  const AccesoWidget({
    Key? key,
    required this.carnetservice,
  }) : super(key: key);
  final Usuario carnetservice;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton.icon(
              icon: const Icon(Icons.close),
              style: ElevatedButton.styleFrom(primary: Colors.red),
              onPressed: () => Navigator.pushReplacementNamed(context, 'check'),
              label: const Text('Cancelar', style: TextStyle(fontSize: 15))),
          SizedBox(width: 10),
          ElevatedButton.icon(
              icon: const Icon(Icons.check),
              style: ElevatedButton.styleFrom(primary: Colors.green),
              onPressed: () async {
                Usuario dato1 = Usuario();
                SharedPreferences prefs = await SharedPreferences.getInstance();
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
                // Control con = Control(
                //   documentoAdmin: dato1.documento,
                //   nombreAdmin: dato1.nombre1,
                //   apellidoAdmin: dato1.apellido1,
                //   documentoUser: carnetservice.usualiorSelect.documento,
                //   nombreUser: carnetservice.usualiorSelect.nombre1,
                //   apellidoUser: carnetservice.usualiorSelect.apellido1,
                //   cargoUser: carnetservice.usualiorSelect.cargo,
                //   dependenciaUser: carnetservice.usualiorSelect.dependencia,
                //   hora: "${now}",
                // );
                // await carnetservice.loadControlAdmin(con);
                print('jfjfjfjfjjfjfjfjrururururururur');
                //  onPressed: () => Navigator.pushReplacementNamed(context, 'control');
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const ControlScreen(),
                        transitionDuration: const Duration(seconds: 0)));
              },
              label: const Text('Aceptar ', style: TextStyle(fontSize: 15))),
        ],
      ),
    );
  }
}
