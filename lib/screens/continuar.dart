import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/screens.dart';

class ContinuoScreen extends StatelessWidget {
  const ContinuoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double tam = MediaQuery.of(context).size.height * 0.17;

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
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () async {}),
          backgroundColor: Colors.white,
          elevation: 1),
      body: Center(
        child: TextButton.icon(
            onPressed: () async {
              late CameraDescription firstCamera;
              late List<CameraDescription> cameras;
              cameras = await availableCameras();
              firstCamera = cameras[1];
              // Navigator.pushReplacement(
              //     context,
              //     PageRouteBuilder(
              //         pageBuilder: (_, __, ___) =>
              //             TakePictureScreen(camera: firstCamera),
              //         transitionDuration: const Duration(seconds: 0)));
            },
            icon: Icon(Icons.abc),
            label: Text('Continuar')),
      ),
    );
  }
}
