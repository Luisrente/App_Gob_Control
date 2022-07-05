import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/screens.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tam = MediaQuery.of(context).size.height * 0.17;
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
              })),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                'Para el control de asistencia se hace uso de camara y gps'),
            MaterialButton(
                child: const Text('Continuar',
                    style: TextStyle(color: Colors.white)),
                color: Colors.black,
                shape: const StadiumBorder(),
                elevation: 0,
                splashColor: Colors.transparent,
                onPressed: () async {
                  // final cameras = await availableCameras();
                  // final firstCamera = cameras[1];
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, __, ___) => Home(),
                          transitionDuration: const Duration(milliseconds: 0)));
                })
          ],
        ),
      ),
    );
  }
}
